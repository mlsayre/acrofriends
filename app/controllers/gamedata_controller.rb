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
      @gamedata.update_attributes!(:r1voted => true, :r1votedfor => (params[:user_id]))
    elsif (params[:round]) == "round2"
      @gamedata.update_attributes!(:r2voted => true, :r2votedfor => (params[:user_id]))
    elsif (params[:round]) == "round3"
      @gamedata.update_attributes!(:r3voted => true, :r3votedfor => (params[:user_id]))
    elsif (params[:round]) == "round4"
      @gamedata.update_attributes!(:r4voted => true, :r4votedfor => (params[:user_id]))
    elsif (params[:round]) == "round5"
      @gamedata.update_attributes!(:r5voted => true, :r5votedfor => (params[:user_id]))
    elsif (params[:round]) == "round6"
      @gamedata.update_attributes!(:r6voted => true, :r6votedfor => (params[:user_id]))
    elsif (params[:round]) == "round7"
      @gamedata.update_attributes!(:r7voted => true, :r7votedfor => (params[:user_id]))
    elsif (params[:round]) == "round8"
      @gamedata.update_attributes!(:r8voted => true, :r8votedfor => (params[:user_id]))
    end
    render :nothing => true
  end

  private
  # Use callbacks to share common setup or constraints between actions.

  # Never trust parameters from the scary internet, only allow the white list through.
  def gamedata_params
    params.require(:gamedata).permit(:r1answer, :r2answer, :r3answer, :r4answer,
      :r5answer, :r6answer, :r7answer, :r8answer, :r1voted, :r2voted,
      :r3voted, :r4voted, :r5voted, :r6voted, :r7voted, :r8voted,
      :r1votedfor, :r2votedfor, :r3votedfor, :r4votedfor, :r5votedfor, :r6votedfor,
      :r7votedfor, :r8votedfor, :r1points, :r2points, :r3points, :r4points,
      :r5points, :r6points, :r7points, :r8points, :game_id)
  end
end
