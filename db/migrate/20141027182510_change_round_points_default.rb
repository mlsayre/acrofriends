class ChangeRoundPointsDefault < ActiveRecord::Migration
  def change
    change_column :gamedata, :r1votedfor, :integer, default: 0
    change_column :gamedata, :r2votedfor, :integer, default: 0
    change_column :gamedata, :r3votedfor, :integer, default: 0
    change_column :gamedata, :r4votedfor, :integer, default: 0
    change_column :gamedata, :r5votedfor, :integer, default: 0
    change_column :gamedata, :r6votedfor, :integer, default: 0
    change_column :gamedata, :r7votedfor, :integer, default: 0
    change_column :gamedata, :r8votedfor, :integer, default: 0
    change_column :gamedata, :r1points, :integer, default: 0
    change_column :gamedata, :r2points, :integer, default: 0
    change_column :gamedata, :r3points, :integer, default: 0
    change_column :gamedata, :r4points, :integer, default: 0
    change_column :gamedata, :r5points, :integer, default: 0
    change_column :gamedata, :r6points, :integer, default: 0
    change_column :gamedata, :r7points, :integer, default: 0
    change_column :gamedata, :r8points, :integer, default: 0
  end
end
