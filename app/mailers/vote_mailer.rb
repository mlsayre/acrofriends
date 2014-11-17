class VoteMailer < ActionMailer::Base
  include Resque::Mailer

  default from: "matt@acrofriends.com"

  def voting_email(user)
    @user = user
    @url  = 'http://acrofriends.com/'
    mail(to: @user.email, from: "AcroFriends", subject: 'AcroFriends voting round starting now.')
  end
end
