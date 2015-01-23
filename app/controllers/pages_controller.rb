class PagesController < ApplicationController
  before_filter :authenticate_user!, :except => [:landing]

  def main
    @gamesinprogressids = Gamedata.where(:user_id => current_user.id).collect(&:game_id)
    @gamesinprogress = Game.where(:id => @gamesinprogressids).where(:gameover => false).all
    @gamescomplete = Game.where(:id => @gamesinprogressids).all
    @gamesinplayround = @gamesinprogress.where('playendtime > ?', DateTime.now.utc)
      .order('playendtime ASC').all
    @gamesinplayroundwaiting = @gamesinprogress.where(:playendtime => nil)
      .order('created_at ASC').all
    @gamesinvoteround = @gamesinprogress.where('playendtime <= ? AND voteendtime >= ?', DateTime.now.utc,
      DateTime.now.utc).order('voteendtime ASC').all
    @gamesinresultsround = @gamescomplete.where('voteendtime < ? AND playercount > ?', DateTime.now.utc, 2)
      .order('voteendtime DESC').first(20)

    @gamestoplayids1 = Game.where('playendtime >= ?', DateTime.now.utc).collect(&:id)
    @gamestoplayids2 = Game.where(:playendtime => nil).collect(&:id)
    @gamestoplayids = @gamestoplayids1.push(@gamestoplayids2)
    @gamestostillplay = Gamedata.where(:user_id => current_user.id).where(:game_id => @gamestoplayids)
      .where(:r4answer => nil).all
    @gamesinvoteroundids = Game.where('playendtime <= ? AND voteendtime >= ?', DateTime.now.utc,
      DateTime.now.utc).collect(&:id)
    @gamestostillvote = Gamedata.where(:user_id => current_user.id).where(:game_id => @gamesinvoteroundids).where(:r1votedfor => 0)
      .where(:r2votedfor => 0).where(:r3votedfor => 0).where(:r4votedfor => 0).all
    @gamesinresultsroundids = @gamesinresultsround.collect(&:id)
    @resultstostillsee = Gamedata.where(:user_id => current_user.id).where(:game_id => @gamesinresultsroundids)
      .where(:seenresults => false).all
  end

  def tipsoff
    current_user.update_attributes(:tooltips => false)
    render :nothing => true
  end

  def tipson
    current_user.update_attributes(:tooltips => true)
    render :nothing => true
  end

  def censoroff
    current_user.update_attributes(:censoron => false)
    render :nothing => true
  end

  def censoron
    current_user.update_attributes(:censoron => true)
    render :nothing => true
  end
end
