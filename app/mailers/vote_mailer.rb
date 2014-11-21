class VoteMailer < ActionMailer::Base
  include Resque::Mailer

  default from: "notifications@acrofriends.com"

  def voting_email(user)
    @queue = :mailer
    @useremail = user
    @url  = 'http://acrofriends.com/'
    mail(to: @useremail, from: "notifications@AcroFriends.com", subject: 'AcroFriends voting round starting now.')
  end
end
