class AddRoundsPlayedToUser < ActiveRecord::Migration
  def change
    add_column :users, :lifetimeroundsplayed, :integer, default: 0
  end
end
