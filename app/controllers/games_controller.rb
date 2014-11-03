class GamesController < ApplicationController
  include ActionView::Helpers::DateHelper
  before_filter :authenticate_user!
  before_action :set_game, only: [:show, :edit, :update, :destroy]

  # GET /games
  # GET /games.json
  def index
    @games = Game.all
  end

  # GET /games/1
  # GET /games/1.json
  def show
    # do not allow players who are not part of the game
    @players = Gamedata.where(:game_id => @game.id).all.collect(&:user_id)
    unless @players.include? User.where(:id => current_user.id).first.id
      redirect_to root_path
      flash[:notice] = "Sorry, you are not a player in that game."
    end

    @timeremainingminutes = (@game.playendtime - DateTime.now)
    if @timeremainingminutes >= 3600
      @timeremaining = distance_of_time_in_words(@timeremainingminutes)
    elsif @timeremainingminutes < 3600
      @timeremaining = "about " + ((@game.playendtime - DateTime.now)/60).round.to_s + " minutes"
    end

    @votetimeremainingminutes = (@game.voteendtime - DateTime.now)
    if @votetimeremainingminutes >= 3600
      @votetimeremaining = distance_of_time_in_words(@votetimeremainingminutes)
    elsif @votetimeremainingminutes < 3600
      @votetimeremaining = "about " + ((@game.voteendtime - DateTime.now)/60).round.to_s + " minutes"
    end

    @gamedata = Gamedata.where(:user_id => current_user.id).where(:game_id => @game.id).first
    @currentgamedata = Gamedata.where(:user_id => current_user.id).where(:game_id => @game.id).first

    @gameanswers = Gamedata.where(:game_id => @game.id)
                   .where("user_id != ?", current_user.id).all

    # results round
    if DateTime.now.utc >= @game.voteendtime && @game.gameover == false
      @game.update_attributes(:gameover => true)
      @gameoverdata = Gamedata.where(:game_id => @game.id).all
      @gameplayers = @gameoverdata.collect(&:user_id)

      # points from voting
      @gameplayers.each do |playerid|
        @r1pointcount = Gamedata.where(:game_id => @game.id).where(:r1votedfor => playerid)
                        .collect(&:r1votedfor).count
        if @gameoverdata.where(:user_id => playerid).first.r1votedfor != 0
          @gameoverdata.where(:user_id => playerid).first.update_attributes(:r1points => @r1pointcount)
        end
        @r2pointcount = Gamedata.where(:game_id => @game.id).where(:r2votedfor => playerid)
                        .collect(&:r2votedfor).count
        if @gameoverdata.where(:user_id => playerid).first.r2votedfor != 0
          @gameoverdata.where(:user_id => playerid).first.update_attributes(:r2points => @r2pointcount)
        end
        @r3pointcount = Gamedata.where(:game_id => @game.id).where(:r3votedfor => playerid)
                        .collect(&:r3votedfor).count
        if @gameoverdata.where(:user_id => playerid).first.r3votedfor != 0
          @gameoverdata.where(:user_id => playerid).first.update_attributes(:r3points => @r3pointcount)
        end
        @r4pointcount = Gamedata.where(:game_id => @game.id).where(:r4votedfor => playerid)
                        .collect(&:r4votedfor).count
        if @gameoverdata.where(:user_id => playerid).first.r4votedfor != 0
          @gameoverdata.where(:user_id => playerid).first.update_attributes(:r4points => @r4pointcount)
        end
        @r5pointcount = Gamedata.where(:game_id => @game.id).where(:r5votedfor => playerid)
                        .collect(&:r5votedfor).count
        if @gameoverdata.where(:user_id => playerid).first.r5votedfor != 0
          @gameoverdata.where(:user_id => playerid).first.update_attributes(:r5points => @r5pointcount)
        end
        @r6pointcount = Gamedata.where(:game_id => @game.id).where(:r6votedfor => playerid)
                        .collect(&:r6votedfor).count
        if @gameoverdata.where(:user_id => playerid).first.r6votedfor != 0
          @gameoverdata.where(:user_id => playerid).first.update_attributes(:r6points => @r6pointcount)
        end
        @r7pointcount = Gamedata.where(:game_id => @game.id).where(:r7votedfor => playerid)
                        .collect(&:r7votedfor).count
        if @gameoverdata.where(:user_id => playerid).first.r7votedfor != 0
          @gameoverdata.where(:user_id => playerid).first.update_attributes(:r7points => @r7pointcount)
        end
        @r8pointcount = Gamedata.where(:game_id => @game.id).where(:r8votedfor => playerid)
                        .collect(&:r8votedfor).count
        if @gameoverdata.where(:user_id => playerid).first.r8votedfor != 0
          @gameoverdata.where(:user_id => playerid).first.update_attributes(:r8points => @r8pointcount)
        end
      end

      # bonus points for round win and for voting for winner - @rXwinnervoters is winner voter array
      if Gamedata.where(:game_id => @game.id).order('r1points DESC').first
        @round1winnerid = Gamedata.where(:game_id => @game.id).order('r1points DESC').first.user_id
        if Gamedata.where(:game_id => @game.id).where(:user_id => @round1winnerid).first.r1votedfor != 0
          Gamedata.where(:game_id => @game.id).where(:user_id => @round1winnerid).first
                .increment!(:r1points, by = 3)
        end
        # 1 point for winning answer voters
        @r1winnervoters = Gamedata.where(:game_id => @game.id).where(:r1votedfor => @round1winnerid)
                          .collect(&:user_id)
        @r1winnervoters.each do |voterid|
          Gamedata.where(:game_id => @game.id).where(:user_id => voterid).first
                  .increment!(:r1points, by = 1)
        end
      end
      if Gamedata.where(:game_id => @game.id).order('r2points DESC').first
        @round2winnerid = Gamedata.where(:game_id => @game.id).order('r2points DESC').first.user_id
        if Gamedata.where(:game_id => @game.id).where(:user_id => @round2winnerid).first.r2votedfor != 0
          Gamedata.where(:game_id => @game.id).where(:user_id => @round2winnerid).first
                .increment!(:r2points, by = 4)
        end
        # 1 point for winning answer voters
        @r2winnervoters = Gamedata.where(:game_id => @game.id).where(:r2votedfor => @round2winnerid)
                          .collect(&:user_id)
        @r2winnervoters.each do |voterid|
          Gamedata.where(:game_id => @game.id).where(:user_id => voterid).first
                  .increment!(:r2points, by = 1)
        end
      end
      if Gamedata.where(:game_id => @game.id).order('r3points DESC').first
        @round3winnerid = Gamedata.where(:game_id => @game.id).order('r3points DESC').first.user_id
        if Gamedata.where(:game_id => @game.id).where(:user_id => @round3winnerid).first.r3votedfor != 0
          Gamedata.where(:game_id => @game.id).where(:user_id => @round3winnerid).first
                .increment!(:r3points, by = 5)
        end
        # 1 point for winning answer voters
        @r3winnervoters = Gamedata.where(:game_id => @game.id).where(:r3votedfor => @round3winnerid)
                          .collect(&:user_id)
        @r3winnervoters.each do |voterid|
          Gamedata.where(:game_id => @game.id).where(:user_id => voterid).first
                  .increment!(:r3points, by = 1)
        end
      end
      if Gamedata.where(:game_id => @game.id).order('r4points DESC').first
        @round4winnerid = Gamedata.where(:game_id => @game.id).order('r4points DESC').first.user_id
        if Gamedata.where(:game_id => @game.id).where(:user_id => @round4winnerid).first.r4votedfor != 0
          Gamedata.where(:game_id => @game.id).where(:user_id => @round4winnerid).first
                .increment!(:r4points, by = 6)
        end
        # 1 point for winning answer voters
        @r4winnervoters = Gamedata.where(:game_id => @game.id).where(:r4votedfor => @round4winnerid)
                          .collect(&:user_id)
        @r4winnervoters.each do |voterid|
          Gamedata.where(:game_id => @game.id).where(:user_id => voterid).first
                  .increment!(:r4points, by = 1)
        end
      end
      if @game.length == "6hour"
        if Gamedata.where(:game_id => @game.id).order('r5points DESC').first
          @round5winnerid = Gamedata.where(:game_id => @game.id).order('r5points DESC').first.user_id
          if Gamedata.where(:game_id => @game.id).where(:user_id => @round5winnerid).first.r5votedfor != 0
            Gamedata.where(:game_id => @game.id).where(:user_id => @round5winnerid).first
                  .increment!(:r5points, by = 3)
          end
          # 1 point for winning answer voters
          @r5winnervoters = Gamedata.where(:game_id => @game.id).where(:r5votedfor => @round5winnerid)
                            .collect(&:user_id)
          @r5winnervoters.each do |voterid|
            Gamedata.where(:game_id => @game.id).where(:user_id => voterid).first
                    .increment!(:r5points, by = 1)
          end
        end
        if Gamedata.where(:game_id => @game.id).order('r6points DESC').first
          @round6winnerid = Gamedata.where(:game_id => @game.id).order('r6points DESC').first.user_id
          if Gamedata.where(:game_id => @game.id).where(:user_id => @round6winnerid).first.r6votedfor != 0
            Gamedata.where(:game_id => @game.id).where(:user_id => @round6winnerid).first
                  .increment!(:r6points, by = 4)
          end
          # 1 point for winning answer voters
          @r6winnervoters = Gamedata.where(:game_id => @game.id).where(:r6votedfor => @round6winnerid)
                            .collect(&:user_id)
          @r6winnervoters.each do |voterid|
            Gamedata.where(:game_id => @game.id).where(:user_id => voterid).first
                    .increment!(:r6points, by = 1)
          end
        end
        if Gamedata.where(:game_id => @game.id).order('r7points DESC').first
          @round7winnerid = Gamedata.where(:game_id => @game.id).order('r7points DESC').first.user_id
          if Gamedata.where(:game_id => @game.id).where(:user_id => @round7winnerid).first.r7votedfor != 0
            Gamedata.where(:game_id => @game.id).where(:user_id => @round7winnerid).first
                  .increment!(:r7points, by = 5)
          end
          # 1 point for winning answer voters
          @r7winnervoters = Gamedata.where(:game_id => @game.id).where(:r7votedfor => @round7winnerid)
                            .collect(&:user_id)
          @r7winnervoters.each do |voterid|
            Gamedata.where(:game_id => @game.id).where(:user_id => voterid).first
                    .increment!(:r7points, by = 1)
          end
        end
        if Gamedata.where(:game_id => @game.id).order('r8points DESC').first
          @round8winnerid = Gamedata.where(:game_id => @game.id).order('r8points DESC').first.user_id
          if Gamedata.where(:game_id => @game.id).where(:user_id => @round8winnerid).first.r8votedfor != 0
            Gamedata.where(:game_id => @game.id).where(:user_id => @round8winnerid).first
                  .increment!(:r8points, by = 6)
          end
          # 1 point for winning answer voters
          @r8winnervoters = Gamedata.where(:game_id => @game.id).where(:r8votedfor => @round8winnerid)
                            .collect(&:user_id)
          @r8winnervoters.each do |voterid|
            Gamedata.where(:game_id => @game.id).where(:user_id => voterid).first
                    .increment!(:r8points, by = 1)
          end
        end
      end

      #add up all rounds for total gamepoints
      if @game.length == "1hour"
        @gameplayers.each do |playerid|
          @playergamedata = Gamedata.where(:game_id => @game.id).where(:user_id => playerid).first
          @gametotalpoints = @playergamedata.r1points + @playergamedata.r2points +
                             @playergamedata.r3points + @playergamedata.r4points
          @playergamedata.update_attributes(:gamepoints => @gametotalpoints)
          User.where(:id => playerid).first.increment!(:lifetimepoints, by = @gametotalpoints)
        end
      elsif @game.length == "6hour"
        @gameplayers.each do |playerid|
          @playergamedata = Gamedata.where(:game_id => @game.id).where(:user_id => playerid).first
          @gametotalpoints = @playergamedata.r1points + @playergamedata.r2points +
                             @playergamedata.r3points + @playergamedata.r4points +
                             @playergamedata.r5points + @playergamedata.r6points +
                             @playergamedata.r7points + @playergamedata.r8points
          @playergamedata.update_attributes(:gamepoints => @gametotalpoints)
          User.where(:id => playerid).first.increment!(:lifetimepoints, by = @gametotalpoints)
        end
      end

      # data for display
      @gamewinnerid = Gamedata.where(:game_id => @game.id).order('gamepoints DESC').first.user_id
      @gamewinner = User.where(:id => @gamewinnerid).first
      @gamewinnerpoints = Gamedata.where(:game_id => @game.id).order('gamepoints DESC').first.gamepoints
      @round1winner = User.where(:id => @round1winnerid).first
      @round2winner = User.where(:id => @round2winnerid).first
      @round3winner = User.where(:id => @round3winnerid).first
      @round4winner = User.where(:id => @round4winnerid).first
      if @game.length == "6hour"
        @round5winner = User.where(:id => @round5winnerid).first
        @round6winner = User.where(:id => @round6winnerid).first
        @round7winner = User.where(:id => @round7winnerid).first
        @round8winner = User.where(:id => @round8winnerid).first
      end

    # points already tallied, gameover now true, just need score data
    elsif DateTime.now.utc >= @game.voteendtime && @game.gameover == true
      @round1winnerid = Gamedata.where(:game_id => @game.id).order('r1points DESC').first.user_id
      @round2winnerid = Gamedata.where(:game_id => @game.id).order('r2points DESC').first.user_id
      @round3winnerid = Gamedata.where(:game_id => @game.id).order('r3points DESC').first.user_id
      @round4winnerid = Gamedata.where(:game_id => @game.id).order('r4points DESC').first.user_id
      @r1winnervoters = Gamedata.where(:game_id => @game.id).where(:r1votedfor => @round1winnerid)
                          .collect(&:user_id)
      @r2winnervoters = Gamedata.where(:game_id => @game.id).where(:r2votedfor => @round2winnerid)
                          .collect(&:user_id)
      @r3winnervoters = Gamedata.where(:game_id => @game.id).where(:r3votedfor => @round3winnerid)
                          .collect(&:user_id)
      @r4winnervoters = Gamedata.where(:game_id => @game.id).where(:r4votedfor => @round4winnerid)
                          .collect(&:user_id)
      if @game.length == "6hour"
        @round5winnerid = Gamedata.where(:game_id => @game.id).order('r5points DESC').first.user_id
        @round6winnerid = Gamedata.where(:game_id => @game.id).order('r6points DESC').first.user_id
        @round7winnerid = Gamedata.where(:game_id => @game.id).order('r7points DESC').first.user_id
        @round8winnerid = Gamedata.where(:game_id => @game.id).order('r8points DESC').first.user_id
        @r5winnervoters = Gamedata.where(:game_id => @game.id).where(:r5votedfor => @round5winnerid)
                            .collect(&:user_id)
        @r6winnervoters = Gamedata.where(:game_id => @game.id).where(:r6votedfor => @round6winnerid)
                            .collect(&:user_id)
        @r7winnervoters = Gamedata.where(:game_id => @game.id).where(:r7votedfor => @round7winnerid)
                            .collect(&:user_id)
        @r8winnervoters = Gamedata.where(:game_id => @game.id).where(:r8votedfor => @round8winnerid)
                            .collect(&:user_id)
      end

      @gamewinnerid = Gamedata.where(:game_id => @game.id).order('gamepoints DESC').first.user_id
      @gamewinner = User.where(:id => @gamewinnerid).first
      @gamewinnerpoints = Gamedata.where(:game_id => @game.id).order('gamepoints DESC').first.gamepoints
      @round1winner = User.where(:id => @round1winnerid).first
      @round2winner = User.where(:id => @round2winnerid).first
      @round3winner = User.where(:id => @round3winnerid).first
      @round4winner = User.where(:id => @round4winnerid).first
      if @game.length == "6hour"
        @round5winner = User.where(:id => @round5winnerid).first
        @round6winner = User.where(:id => @round6winnerid).first
        @round7winner = User.where(:id => @round7winnerid).first
        @round8winner = User.where(:id => @round8winnerid).first
      end

    end
    @ranknumbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]

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
    if Gamedata.where('user_id = ?', current_user.id).all.collect(&:game_id) == []
      usergames = [1, 2]
    else
      usergames = Gamedata.where('user_id = ?', current_user.id).all.collect(&:game_id)
    end
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
