class Lightning < ActiveRecord::Base
  has_many :users
  has_many :lightningdata
end
