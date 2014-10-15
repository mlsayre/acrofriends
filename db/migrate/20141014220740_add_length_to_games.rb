class AddLengthToGames < ActiveRecord::Migration
  def change
    add_column :games, :length, :string
    add_column :games, :playendtime, :datetime
    add_column :games, :voteendtime, :datetime
  end
end
