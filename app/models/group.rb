class Group < ActiveRecord::Base
  has_many :memberships
  has_many :users, :through => :memberships
  has_many :chats

  validates_presence_of :name

  validates_length_of :name, :maximum => 24
  validates_length_of :name, :minimum => 3
  validates_length_of :password, :maximum => 24

  validates :name, :uniqueness => {:case_sensitive => false}
end
