class VotingMailerJob
  @queue = :voting_email_queue

  def self.perform(user)
    #Resque.enqueue_in(2.minutes, VoteMailer.voting_email(@user))
    VoteMailer.voting_email(user).deliver
    render :nothing => true
  end
end
