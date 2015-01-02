class RenameLightningTable < ActiveRecord::Migration
  def change
    rename_table :lightning, :lightnings
  end
end
