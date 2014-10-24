class Chat < ActiveRecord::Base
  include ActionView::Helpers::DateHelper

  belongs_to :user
  belongs_to :group

  validates :message,  obscenity: { sanitize: true, replacement: :stars }

  def chattime
    time_ago_in_words(created_at, include_seconds: true)
  end
end
