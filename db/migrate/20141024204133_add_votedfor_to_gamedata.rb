class AddVotedforToGamedata < ActiveRecord::Migration
  def change
    add_column :gamedata, :r1votedfor, :integer
    add_column :gamedata, :r2votedfor, :integer
    add_column :gamedata, :r3votedfor, :integer
    add_column :gamedata, :r4votedfor, :integer
  end
end
