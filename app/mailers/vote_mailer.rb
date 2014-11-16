class VoteMailer < ActionMailer::Base
  default from: "matt@acrofriends.com"

  def voting_email(user)
    @user = user
    @url  = 'http://acrofriends.com/'
    mail(to: @user.email, subject: 'AcroFriends voting round starting now.')
  end
end
