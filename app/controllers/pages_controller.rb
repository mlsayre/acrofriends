class PagesController < ApplicationController
  before_filter :authenticate_user!, :except => [:landing]

  def main
    @gamesinprogressids = Gamedata.where(:user_id => current_user.id).collect(&:game_id)
    @gamesinprogress = Game.where(:id => @gamesinprogressids).where(:gameover => false).all
    @gamesinplayround = @gamesinprogress.where('playendtime > ?', DateTime.now.utc).all

  end
end
