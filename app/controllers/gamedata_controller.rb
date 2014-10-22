class GamedataController < ApplicationController
  def updateanswer
    @gamedata = Gamedata.where(:user_id => current_user.id)
                .where('game_id = ?', (params[:gamedata][:game_id])).first
    @gamedata.update_attributes!(gamedata_params)
    render :nothing => true
  end

    private
    # Use callbacks to share common setup or constraints between actions.

    # Never trust parameters from the scary internet, only allow the white list through.
    def gamedata_params
      params.require(:gamedata).permit(:r1answer, :r2answer, :r3answer, :r4answer, :game_id)
    end
end
