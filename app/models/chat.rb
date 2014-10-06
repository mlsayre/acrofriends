class Chat < ActiveRecord::Base
  belongs_to :user
  belongs_to :group

  def chattime
    timedif = DateTime.now.utc.to_i - created_at.utc.to_i
    if timedif <=
  end
end
