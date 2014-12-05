class AddSeenResultsToGamedata < ActiveRecord::Migration
  def change
    add_column :gamedata, :seenresults, :boolean, default: false
  end
end
