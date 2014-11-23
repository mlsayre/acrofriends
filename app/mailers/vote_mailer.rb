class VoteMailer < ActionMailer::Base

  default from: "notifications@acrofriends.com"

  def voting_email(info)
    @votingemail = info
    mail(to: @votingemail[:email], from: "notifications@AcroFriends.com", subject: 'AcroFriends voting round starting now.')
  end
end
