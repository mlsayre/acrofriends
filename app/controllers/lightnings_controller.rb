class LightningsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_lightning, except: [:index, :create, :updateanswer, :vote,
    :thumbsup, :thumbsdown, :heart, :switchplayvote]

  def index
    @lightning = Lightning.new
    @finishedlightningnewvotes = Lightning.where(:user_id => current_user.id).where(:completed => true)
      .where("whovoted != ?", "").order('created_at DESC').all
    @finishedlightning = Lightning.where(:user_id => current_user.id).where(:completed => true)
      .where("whovoted = ?", "").order('created_at DESC').all
  end

  def show
    if @lightning.completed == true
      @lightning.update_attributes(:whovoted => "")
    end
  end

  def updateanswer
    @lightning = Lightning.where(:user_id => current_user.id)
                .where('id = ?', (params[:lightning][:id])).first
    @lightning.update_attributes(lightning_params)
    @lightning.update_attributes(:completed => true)
    render :nothing => true
  end

  def vote
    @lightningvotedids = Lightningdata.where(:user_id => current_user.id).collect(&:lightning_id)
    @lightning = Lightning.where.not(:user_id => current_user.id).where.not(:id => @lightningvotedids)
      .where("votes < ?", 3).where("answer != ?", "").all
    @idnumbers = [1, 2, 3]
    @lightningnew = Lightning.new
  end

  def thumbsup
    if Lightningdata.where(:lightning_id => params[:lightning_id]).where(:user_id => current_user.id).first
      @lightningdata = Lightningdata.where(:lightning_id => params[:lightning_id])
        .where(:user_id => current_user.id).first
      if @lightningdata.thumbsup == nil
        @lightning = Lightning.where(:id => params[:lightning_id]).first
        @lightning.increment!(:thumbsup, by = 1)
        @lightning.update_attributes(:whovoted => current_user.username)
        @user = User.where(:id => @lightning.user_id).first
        @user.increment!(:lifetimelightningthumbsup, by = 1)
        current_user.increment!(:lifetimelightningthumbsupgiven, by = 1)
      elsif @lightningdata.thumbsup == false
        @lightning = Lightning.where(:id => params[:lightning_id]).first
        @lightning.increment!(:thumbsup, by = 1)
        @lightning.decrement!(:thumbsdown, by = 1)
        @user = User.where(:id => @lightning.user_id).first
        @user.increment!(:lifetimelightningthumbsup, by = 1)
        @user.decrement!(:lifetimelightningthumbsdown, by = 1)
        current_user.increment!(:lifetimelightningthumbsupgiven, by = 1)
        current_user.decrement!(:lifetimelightningthumbsdowngiven, by = 1)
      end

      if @lightningdata.userhasvoted == false
        Lightning.where(:id => params[:lightning_id]).first.increment!(:votes, by = 1)
      end
      @lightningdata.update_attributes(:thumbsup => true, :userhasvoted => true)

    else
      @lightningdata = Lightningdata.new
      @lightning = Lightning.where(:id => params[:lightning_id]).first
      @lightning.increment!(:votes, by = 1)
      @lightning.increment!(:thumbsup, by = 1)
      @lightning.update_attributes(:whovoted => current_user.username)
      @user = User.where(:id => @lightning.user_id).first
      @user.increment!(:lifetimelightningthumbsup, by = 1)
      current_user.increment!(:lifetimelightningthumbsupgiven, by = 1)
      @lightningdata.update_attributes(:user_id => current_user.id, :lightning_id => params[:lightning_id],
        :thumbsup => true, :userhasvoted => true)
    end
    render :nothing => true
  end

  def thumbsdown
    if Lightningdata.where(:lightning_id => params[:lightning_id]).where(:user_id => current_user.id).first
      @lightningdata = Lightningdata.where(:lightning_id => params[:lightning_id])
        .where(:user_id => current_user.id).first
      if @lightningdata.thumbsup == nil
        @lightning = Lightning.where(:id => params[:lightning_id]).first
        @lightning.increment!(:thumbsdown, by = 1)
        @lightning.update_attributes(:whovoted => current_user.username)
        @user = User.where(:id => @lightning.user_id).first
        @user.increment!(:lifetimelightningthumbsdown, by = 1)
        current_user.increment!(:lifetimelightningthumbsdowngiven, by = 1)
      elsif @lightningdata.thumbsup == true
        @lightning = Lightning.where(:id => params[:lightning_id]).first
        @lightning.increment!(:thumbsdown, by = 1)
        @lightning.decrement!(:thumbsup, by = 1)
        @user = User.where(:id => @lightning.user_id).first
        @user.increment!(:lifetimelightningthumbsdown, by = 1)
        @user.decrement!(:lifetimelightningthumbsup, by = 1)
        current_user.increment!(:lifetimelightningthumbsdowngiven, by = 1)
        current_user.decrement!(:lifetimelightningthumbsupgiven, by = 1)
        if @lightningdata.heart == true
          @user.decrement!(:lifetimelightninghearts, by = 1)
          current_user.decrement!(:lifetimelightningheartsgiven, by = 1)
          @lightning.decrement!(:hearts, by = 1)
        end
      end

      if @lightningdata.userhasvoted == false
        Lightning.where(:id => params[:lightning_id]).first.increment!(:votes, by = 1)
      end
      @lightningdata.update_attributes(:thumbsup => false, :heart => false, :userhasvoted => true)
    else
      @lightningdata = Lightningdata.new
      @lightning = Lightning.where(:id => params[:lightning_id]).first
      @lightning.increment!(:votes, by = 1)
      @lightning.increment!(:thumbsdown, by = 1)
      @lightning.update_attributes(:whovoted => current_user.username)
      @user = User.where(:id => @lightning.user_id).first
      @user.increment!(:lifetimelightningthumbsdown, by = 1)
      current_user.increment!(:lifetimelightningthumbsdowngiven, by = 1)
      @lightningdata.update_attributes(:user_id => current_user.id, :lightning_id => params[:lightning_id],
        :thumbsup => false, :userhasvoted => true)
    end
    render :nothing => true
  end

  def heart
    if Lightningdata.where(:lightning_id => params[:lightning_id]).where(:user_id => current_user.id).first
      @lightningdata = Lightningdata.where(:lightning_id => params[:lightning_id])
        .where(:user_id => current_user.id).first
      if @lightningdata.heart == false
        @lightning = Lightning.where(:id => params[:lightning_id]).first
        @lightning.increment!(:hearts, by = 1)
        @user = User.where(:id => @lightning.user_id).first
        @user.increment!(:lifetimelightninghearts, by = 1)
        current_user.increment!(:lifetimelightningheartsgiven, by = 1)
        @lightningdata.update_attributes(:heart => true)
      else
        @lightning = Lightning.where(:id => params[:lightning_id]).first
        @lightning.decrement!(:hearts, by = 1)
        @user = User.where(:id => @lightning.user_id).first
        @user.decrement!(:lifetimelightninghearts, by = 1)
        current_user.decrement!(:lifetimelightningheartsgiven, by = 1)
        @lightningdata.update_attributes(:heart => false)
      end
    else
      @lightningdata = Lightningdata.new
      @lightning = Lightning.where(:id => params[:lightning_id]).first
      @lightning.increment!(:hearts, by = 1)
      @user = User.where(:id => @lightning.user_id).first
      @user.increment!(:lifetimelightninghearts, by = 1)
      current_user.increment!(:lifetimelightningheartsgiven, by = 1)
      @lightningdata.update_attributes(:user_id => current_user.id, :lightning_id => params[:lightning_id],
        :heart => true)
    end
    render :nothing => true
  end

  def switchplayvote
    current_user.update_attributes(:nextlightning => params[:playvote])
    render :nothing => true
  end

  def create
    if Lightning.where(:user_id => current_user.id).last == nil ||
      Lightning.where(:user_id => current_user.id).last.completed == true
      @lightning = Lightning.new(lightning_params)
      # category and letters
      @lightning.category = File.new("config/CategoryPool").readlines.sample(1).join.sub("\n", "")
      def randomletters
        @badplaywords = File.new("config/BadPlayWords").readlines.map! {|x| x.sub("\n", "")}
        @acrosize = rand(3..6)
        @potentialletters = File.new("config/LetterPool").readlines.sample(@acrosize).join.gsub("\n", "")
        if @badplaywords.any?{|words| @potentialletters.include?(words)}
          randomletters
        else
          @lightning.letters = @potentialletters
        end
      end
      randomletters

      respond_to do |format|
        if @lightning.save
          format.html { redirect_to @lightning, notice: 'New lightning game created!' }
          format.json { render :show, status: :created, location: @lightning }
        else
          format.html { render :new }
          format.json { render json: @lightning.errors, status: :unprocessable_entity }
        end
      end
    else
      @lightning = Lightning.where(:user_id => current_user.id).where(:completed => false).last
      respond_to do |format|
        format.html { redirect_to @lightning }
        format.json { render :show, status: :created, location: @lightning }
      end
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lightning
      @lightning = Lightning.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lightning_params
      params.require(:lightning).permit(:user_id, :letters, :category, :thumbsup, :votes, :answer)
    end
end
