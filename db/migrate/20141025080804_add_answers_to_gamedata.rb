class AddAnswersToGamedata < ActiveRecord::Migration
  def change
    add_column :gamedata, :r5answer, :string
    add_column :gamedata, :r6answer, :string
    add_column :gamedata, :r7answer, :string
    add_column :gamedata, :r8answer, :string
    add_column :gamedata, :r5voted, :boolean
    add_column :gamedata, :r6voted, :boolean
    add_column :gamedata, :r7voted, :boolean
    add_column :gamedata, :r8voted, :boolean
    add_column :gamedata, :r5votedfor, :integer
    add_column :gamedata, :r6votedfor, :integer
    add_column :gamedata, :r7votedfor, :integer
    add_column :gamedata, :r8votedfor, :integer
    add_column :gamedata, :r1points, :integer
    add_column :gamedata, :r2points, :integer
    add_column :gamedata, :r3points, :integer
    add_column :gamedata, :r4points, :integer
    add_column :gamedata, :r5points, :integer
    add_column :gamedata, :r6points, :integer
    add_column :gamedata, :r7points, :integer
    add_column :gamedata, :r8points, :integer
    add_column :users, :lifetimepoints, :integer, default: 0
  end
end
