class LightningsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_lightning, except: [:index, :create]

  def index
    @lightning = Lightning.new
  end

  def show

  end

  def updateanswer

  end

  def create
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

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lightning
      @lightning = Lightning.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lightning_params
      params.require(:lightning).permit(:user_id, :letters, :category, :thumbsup, :votes)
    end
end
