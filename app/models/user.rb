class User < ActiveRecord::Base
  has_many :memberships
  has_many :groups, :through => :memberships
  has_many :chats
  has_many :gamechats
  has_many :gamedata

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauth_providers => [:facebook, :twitter, :google_oauth2]

  validates_presence_of :username

  validates_length_of :username, :maximum => 15
  validates_length_of :username, :minimum => 3
  validates_length_of :about, :maximum => 80

  validates :email, :uniqueness => {:case_sensitive => false}
  validates :username, :uniqueness => {:case_sensitive => false}

  has_attached_file :avatar, :styles => {
    small: '80x80>',
    large: '300x300>'
    },
    :default_url => 'https://s3-us-west-2.amazonaws.com/apavatars/ap_generic_avatar80.png'
  # validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  # validates_attachment_file_name :avatar, :matches => [/png\Z/, /jpe?g\Z/]
  # Explicitly do not validate
  do_not_validate_attachment_file_type :avatar

  def averagepointsperround
    if self.lifetimeroundsplayed > 0
      (self.lifetimepoints.round(2) / self.lifetimeroundsplayed.round(2)).round(2)
    else
      0.00
    end
  end

  def percentthumbsup
    if self.lifetimelightningthumbsup > 0
      ((self.lifetimelightningthumbsup.round(2) / (self.lifetimelightningthumbsup.round(2) + self.lifetimelightningthumbsdown.round(2))) * 100).round(2)
    else
      0.00
    end
  end

  def percentthumbsupgiven
    if self.lifetimelightningthumbsupgiven > 0
      ((self.lifetimelightningthumbsupgiven.round(2) / (self.lifetimelightningthumbsupgiven.round(2) + self.lifetimelightningthumbsdowngiven.round(2))) * 100).round(2)
    else
      0.00
    end
  end

  def lightningvotesmade
    self.lifetimelightningthumbsupgiven + self.lifetimelightningthumbsdowngiven
  end

  def percentheart
    if self.lifetimelightninghearts > 0
      ((self.lifetimelightninghearts.round(2) / (self.lifetimelightningthumbsup.round(2) + self.lifetimelightningthumbsdown.round(2))) * 100).round(2)
    else
      0.00
    end
  end

  def percentheartgiven
    if self.lifetimelightningheartsgiven > 0
      ((self.lifetimelightningheartsgiven.round(2) / (self.lifetimelightningthumbsupgiven.round(2) + self.lifetimelightningthumbsdowngiven.round(2))) * 100).round(2)
    else
      0.00
    end
  end

  def lightningtotalvotesreceived
    self.lifetimelightningthumbsup + self.lifetimelightningthumbsdown
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      if auth.provider == "twitter"
        user.username = auth.info.nickname
        user.email = auth.info.nickname + "@twitter.com"
        user.avatar = auth["info"]["image"].sub("_normal", "")
      elsif auth.provider == "facebook"
        user.username = auth.info.first_name[0...12] + rand(1000).to_s
        user.email = auth["info"]["email"]
        user.avatar = auth["info"]["image"]
      else # Google login
        user.username = auth.info.first_name[0...12] + rand(1000).to_s
        user.email = auth["info"]["email"]
        user.avatar = auth["info"]["image"]
      end

    end
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def password_required?
    super && provider.blank?
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end
end
