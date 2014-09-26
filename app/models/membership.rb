class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :group

  validates :group_id, :uniqueness => {:scope=>:user_id, message: " already joined."}
end
