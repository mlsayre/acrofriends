class GamesController < ApplicationController
  include ActionView::Helpers::DateHelper
  before_action :set_game, only: [:show, :edit, :update, :destroy]

  # GET /games
  # GET /games.json
  def index
    @games = Game.all
  end

  # GET /games/1
  # GET /games/1.json
  def show
    @timeremainingminutes = (@game.playendtime - DateTime.now)
    if @timeremainingminutes >= 3600
      @timeremaining = distance_of_time_in_words(@timeremainingminutes)
    elsif @timeremainingminutes < 3600
      @timeremaining = "about " + ((@game.playendtime - DateTime.now)/60).round.to_s + " minutes"
    end
    @gamedata = Gamedata.where(:user_id => current_user.id).where(:game_id => @game.id).first
    @currentgamedata = Gamedata.where(:user_id => current_user.id).where(:game_id => @game.id).first

    @gameanswers = Gamedata.where(:game_id => @game.id)
                   .where("user_id != ?", current_user.id).all

    if DateTime.now.utc > @game.voteendtime
      @gameoverdata = Gamedata.where(:game_id => @game.id).all
      @gameplayers = @gameoverdata.collect(&:user_id)
      @gameplayers.each do |playerid|
        @r1pointcount = Gamedata.where(:game_id => @game.id).where(:r1votedfor => playerid)
                        .collect(&:r1votedfor).count
        @gameoverdata.where(:user_id => playerid).first.update_attributes(:r1points => @r1pointcount)
        @r2pointcount = Gamedata.where(:game_id => @game.id).where(:r2votedfor => playerid)
                        .collect(&:r2votedfor).count
        @gameoverdata.where(:user_id => playerid).first.update_attributes(:r2points => @r2pointcount)
        @r3pointcount = Gamedata.where(:game_id => @game.id).where(:r3votedfor => playerid)
                        .collect(&:r3votedfor).count
        @gameoverdata.where(:user_id => playerid).first.update_attributes(:r3points => @r3pointcount)
        @r4pointcount = Gamedata.where(:game_id => @game.id).where(:r4votedfor => playerid)
                        .collect(&:r4votedfor).count
        @gameoverdata.where(:user_id => playerid).first.update_attributes(:r4points => @r4pointcount)
        @r5pointcount = Gamedata.where(:game_id => @game.id).where(:r5votedfor => playerid)
                        .collect(&:r5votedfor).count
        @gameoverdata.where(:user_id => playerid).first.update_attributes(:r5points => @r5pointcount)
        @r6pointcount = Gamedata.where(:game_id => @game.id).where(:r6votedfor => playerid)
                        .collect(&:r6votedfor).count
        @gameoverdata.where(:user_id => playerid).first.update_attributes(:r6points => @r6pointcount)
        @r7pointcount = Gamedata.where(:game_id => @game.id).where(:r7votedfor => playerid)
                        .collect(&:r7votedfor).count
        @gameoverdata.where(:user_id => playerid).first.update_attributes(:r7points => @r7pointcount)
        @r8pointcount = Gamedata.where(:game_id => @game.id).where(:r8votedfor => playerid)
                        .collect(&:r8votedfor).count
        @gameoverdata.where(:user_id => playerid).first.update_attributes(:r8points => @r8pointcount)

        @gametotalpoints = @gameoverdata.where(:user_id => playerid).first.r1points
        @gameoverdata.where(:user_id => playerid).first.update_attributes(:gamepoints => @gametotalpoints)
      end
    end

  end

  # GET /games/new
  def new
    @game = Game.new
  end

  # GET /games/1/edit
  def edit
  end

  # POST /games
  # POST /games.json
  def create
    usergames = Gamedata.where('user_id = ?', current_user.id).all.collect(&:game_id)
    if (params[:game][:length]) == "1hour" &&
      Game.where('length = ? AND playercount < ? AND playendtime > ?
         AND group_id = ? AND not id IN (?)',
         "1hour", 13, DateTime.now + 0.01389,
         (params[:game][:group_id]), usergames).first
      @game = Game.where('length = ? AND playercount < ? AND playendtime > ?
        AND group_id = ? AND not id IN (?)',
        "1hour", 13, DateTime.now + 0.01389,
        (params[:game][:group_id]), usergames).first
      @game.increment!(:playercount)
      Gamedata.create(:user_id => current_user.id, :game_id => @game.id)
      redirect_to game_path(@game)
      flash[:notice] = "Joining this game, enjoy!"
    elsif (params[:game][:length]) == "6hour" &&
      Game.where('length = ? AND playercount < ? AND playendtime > ?
         AND group_id = ? AND not id IN (?)',
         "6hour", 13, DateTime.now + 0.02778,
         (params[:game][:group_id]), usergames).first
      @game = Game.where('length = ? AND playercount < ? AND playendtime > ?
         AND group_id = ? AND not id IN (?)',
         "6hour", 13, DateTime.now + 0.02778,
         (params[:game][:group_id]), usergames).first
      @game.increment!(:playercount)
      Gamedata.create(:user_id => current_user.id, :game_id => @game.id)
      redirect_to game_path(@game)
      flash[:notice] = "Joining this game, enjoy!"
    else
      # create game's name
      @gamename1 = File.new("config/GameName1").readlines.sample(1).join.sub("\n", "")
      @gamename2 = File.new("config/GameName2").readlines.sample(1).join.sub("\n", "")
      @gamename3 = File.new("config/GameName3").readlines.sample(1).join.sub("\n", "")

      #create game's data
      @game = Game.new(game_params)
      @game.name = @gamename1 + " " + @gamename2 + " " + @gamename3
      @game.r1cat = File.new("config/CategoryPool").readlines.sample(1).join.sub("\n", "")
      @game.r2cat = File.new("config/CategoryPool").readlines.sample(1).join.sub("\n", "")
      @game.r3cat = File.new("config/CategoryPool").readlines.sample(1).join.sub("\n", "")
      @game.r4cat = File.new("config/CategoryPool").readlines.sample(1).join.sub("\n", "")
      @game.r5cat = File.new("config/CategoryPool").readlines.sample(1).join.sub("\n", "")
      @game.r6cat = File.new("config/CategoryPool").readlines.sample(1).join.sub("\n", "")
      @game.r7cat = File.new("config/CategoryPool").readlines.sample(1).join.sub("\n", "")
      @game.r8cat = File.new("config/CategoryPool").readlines.sample(1).join.sub("\n", "")
      @game.r1letters = File.new("config/LetterPool").readlines.sample(3).join.gsub("\n", "")
      @game.r2letters = File.new("config/LetterPool").readlines.sample(4).join.gsub("\n", "")
      @game.r3letters = File.new("config/LetterPool").readlines.sample(5).join.gsub("\n", "")
      @game.r4letters = File.new("config/LetterPool").readlines.sample(6).join.gsub("\n", "")
      @game.r5letters = File.new("config/LetterPool").readlines.sample(3).join.gsub("\n", "")
      @game.r6letters = File.new("config/LetterPool").readlines.sample(4).join.gsub("\n", "")
      @game.r7letters = File.new("config/LetterPool").readlines.sample(5).join.gsub("\n", "")
      @game.r8letters = File.new("config/LetterPool").readlines.sample(6).join.gsub("\n", "")
      @game.increment!(:playercount)
      if (params[:game][:length]) == "1hour"
        gametime = 1
      elsif (params[:game][:length]) == "6hour"
        gametime = 6
      elsif (params[:game][:length]) == "1day"
        gametime = 24
      end
      @game.playendtime = DateTime.now.utc + gametime.hours
      @game.voteendtime = DateTime.now.utc + (gametime* 2).hours

      respond_to do |format|
        if @game.save
          Gamedata.create(:user_id => current_user.id, :game_id => @game.id)
          format.html { redirect_to @game, notice: 'New game created!' }
          format.json { render :show, status: :created, location: @game }
        else
          format.html { render :new }
          format.json { render json: @game.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /games/1
  # PATCH/PUT /games/1.json
  def update
    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to @game, notice: 'Game was successfully updated.' }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game.destroy
    respond_to do |format|
      format.html { redirect_to games_url, notice: 'Game was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_params
      params.require(:game).permit(:r1letters, :r2letters, :r3letters, :r4letters,
        :r5letters, :r6letters, :r7letters, :r8letters, :r1cat, :r2cat, :r3cat,
        :r4cat, :r5cat, :r6cat, :r7cat, :r8cat, :name, :group_id, :length, :playendtime,
        :voteendtime, :playercount)
    end
end
