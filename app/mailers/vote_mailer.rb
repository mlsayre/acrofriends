class VoteMailer < ActionMailer::Base

  default from: "notifications@acrofriends.com"

  def voting_email(info)
    @gamedataemail = info
    @game = Game.find(@gamedataemail.game_id)
    @user = User.find(@gamedataemail.user_id)
    mail(to: @user.email, from: "notifications@AcroFriends.com",
      subject: 'AcroFriends voting round starting now.')
  end
end
