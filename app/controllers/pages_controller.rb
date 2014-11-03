class PagesController < ApplicationController
  before_filter :authenticate_user!, :except => [:landing]

  def main
    @gamesinprogressids = Gamedata.where(:user_id => current_user.id).collect(&:game_id)
    @gamesinprogress = Game.where(:id => @gamesinprogressids).where(:gameover => false).all
    @gamescomplete = Game.where(:id => @gamesinprogressids).all
    @gamesinplayround = @gamesinprogress.where('playendtime > ?', DateTime.now.utc)
      .order('playendtime ASC').all
    @gamesinvoteround = @gamesinprogress.where('playendtime <= ? AND voteendtime >= ?', DateTime.now.utc,
      DateTime.now.utc).order('voteendtime ASC').all
    @gamesinresultsround = @gamescomplete.where('voteendtime < ?', DateTime.now.utc)
      .order('voteendtime DESC').last(20)
  end
end
