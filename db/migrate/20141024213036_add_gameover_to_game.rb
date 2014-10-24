class AddGameoverToGame < ActiveRecord::Migration
  def change
    add_column :games, :gameover, :boolean, default: false
  end
end
