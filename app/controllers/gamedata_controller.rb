class GamedataController < ApplicationController
  def updateanswer
    @gamedata = Gamedata.where(:user_id => current_user.id)
                .where('game_id = ?', (params[:gamedata][:game_id])).first
    @gamedata.update_attributes!(gamedata_params)
    render :nothing => true
  end

  def vote
    @gamedata = Gamedata.where(:user_id => current_user.id)
                .where('game_id = ?', (params[:game_id])).first
    if (params[:round]) == "round1"
      @gamedata.update_attributes!(:r1voted => true, :r1votedfor => (params[:id]))
    elsif (params[:round]) == "round2"
      @gamedata.update_attributes!(:r2voted => true, :r2votedfor => (params[:id]))
    elsif (params[:round]) == "round3"
      @gamedata.update_attributes!(:r3voted => true, :r3votedfor => (params[:id]))
    elsif (params[:round]) == "round4"
      @gamedata.update_attributes!(:r4voted => true, :r4votedfor => (params[:id]))
    end
    render :nothing => true
  end

  private
  # Use callbacks to share common setup or constraints between actions.

  # Never trust parameters from the scary internet, only allow the white list through.
  def gamedata_params
    params.require(:gamedata).permit(:r1answer, :r2answer, :r3answer, :r4answer, :game_id)
  end
end
