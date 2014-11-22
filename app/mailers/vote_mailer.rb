class VoteMailer < ActionMailer::Base

  default from: "notifications@acrofriends.com"

  def voting_email(user)
    @useremail = user
    @url  = 'http://acrofriends.com/'
    mail(to: @useremail, from: "notifications@AcroFriends.com", subject: 'AcroFriends voting round starting now.')
  end
end
