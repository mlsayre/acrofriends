class AddDefaultToVotes < ActiveRecord::Migration
  def change
    change_column :lightnings, :votes, :integer, default: 0
  end
end
