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
    if @gamestoplayids2 != [] && @gamestoplayids1 != []
      @gamestoplayids = @gamestoplayids1.push(@gamestoplayids2)
    elsif @gamestoplayids2 != [] && @gamestoplayids1 == []
      @gamestoplayids = @gamestoplayids2
    elsif @gamestoplayids2 == [] && @gamestoplayids1 != []
      @gamestoplayids = @gamestoplayids1
    else
      @gamestoplayids = []
    end
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

  def rankings
    @lifeavgpointrank = User.all.sort {|a,b| a.averagepointsperround <=> b.averagepointsperround}.reverse!
    @userlifeavgpointrank = @lifeavgpointrank.collect(&:id).index(current_user.id) + 1
    @userlifetimepointsrank = User.order('lifetimepoints DESC').collect(&:id).index(current_user.id) + 1
    @userlifetimeroundsrank = User.order('lifetimeroundsplayed DESC').collect(&:id).index(current_user.id) + 1

    # lightning stats
    @thumbsuppercentrank = User.all.sort {|a,b| a.percentthumbsup <=> b.percentthumbsup}.reverse!
    @userthumbsuppercentrank = @thumbsuppercentrank.collect(&:id).index(current_user.id) + 1
    @heartpercentrank = User.all.sort {|a,b| a.percentheart <=> b.percentheart}.reverse!
    @userheartpercentrank = @heartpercentrank.collect(&:id).index(current_user.id) + 1
    @userlightningplayedrank = User.order('lifetimelightningsplayed DESC').collect(&:id).index(current_user.id) + 1
    @thumbsupgivenpercentrank = User.all.sort {|a,b| a.percentthumbsupgiven <=> b.percentthumbsupgiven}.reverse!
    @userthumbsupgivenpercentrank = @thumbsupgivenpercentrank.collect(&:id).index(current_user.id) + 1
    @heartgivenpercentrank = User.all.sort {|a,b| a.percentheartgiven <=> b.percentheartgiven}.reverse!
    @userheartgivenpercentrank = @heartgivenpercentrank.collect(&:id).index(current_user.id) + 1
  end
end
