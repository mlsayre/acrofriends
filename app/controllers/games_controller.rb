class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]

  # GET /games
  # GET /games.json
  def index
    @games = Game.all
  end

  # GET /games/1
  # GET /games/1.json
  def show
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
    if Game.where('length = ? AND playercount < ? AND playendtime > ?',
         (params[:game][:length]), 13, DateTime.now + 0.00555).first
      @game = Game.where('length = ? AND playercount < ? AND playendtime > ?',
         (params[:game][:length]), 13, DateTime.now + 0.00555).first
      redirect_to game_path(@game)
      flash[:notice] = "You can join a game."
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
      @game.r1letters = File.new("config/LetterPool").readlines.sample(3).join.gsub("\n", "")
      @game.r2letters = File.new("config/LetterPool").readlines.sample(4).join.gsub("\n", "")
      @game.r3letters = File.new("config/LetterPool").readlines.sample(5).join.gsub("\n", "")
      @game.r4letters = File.new("config/LetterPool").readlines.sample(6).join.gsub("\n", "")

      respond_to do |format|
        if @game.save
          format.html { redirect_to @game, notice: 'Game was successfully created.' }
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
        :r1cat, :r2cat, :r3cat, :r4cat, :name, :group_id, :length, :playendtime,
        :voteendtime, :playercount)
    end
end
