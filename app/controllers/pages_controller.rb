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
    @gamesinresultsround = @gamescomplete.where('voteendtime < ? AND playercount > ?', DateTime.now.utc, 2)
      .order('voteendtime DESC').first(20)
  end

  def tipsoff
    current_user.update_attributes(:tooltips => false)
    render :nothing => true
  end

  def tipson
    current_user.update_attributes(:tooltips => true)
    render :nothing => true
  end

  def sendemail
    @user = current_user
    #Resque.enqueue(VotingMailerJob, @user)
    #Resque.enqueue_in(30.seconds, VotingMailerJob, @user)
    VoteMailer.voting_email(@user).deliver_in(20.seconds)
    render :nothing => true
  end
end
