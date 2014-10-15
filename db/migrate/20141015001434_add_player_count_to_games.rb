class AddPlayerCountToGames < ActiveRecord::Migration
  def change
    add_column :games, :playercount, :integer, default: 0
  end
end
