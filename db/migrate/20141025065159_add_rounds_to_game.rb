class AddRoundsToGame < ActiveRecord::Migration
  def change
    add_column :games, :r5letters, :string
    add_column :games, :r6letters, :string
    add_column :games, :r7letters, :string
    add_column :games, :r8letters, :string
    add_column :games, :r5cat, :string
    add_column :games, :r6cat, :string
    add_column :games, :r7cat, :string
    add_column :games, :r8cat, :string
  end
end
