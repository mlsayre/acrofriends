class Gamedata < ActiveRecord::Base
  belongs_to :game
  has_many :users
end
