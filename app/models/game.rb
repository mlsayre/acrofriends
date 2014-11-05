class Game < ActiveRecord::Base
  belongs_to :group
  has_many :users
  has_many :gamedata
  has_many :gamechats
end
