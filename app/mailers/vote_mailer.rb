class VoteMailer < ActionMailer::Base
  include Resque::Mailer

  default from: "matt@acrofriends.com"

  def voting_email(user)
    @queue = :mailer
    @user = user
    @url  = 'http://acrofriends.com/'
    mail(to: @user.email, from: "notifications@AcroFriends.com", subject: 'AcroFriends voting round starting now.')
  end
end
