class AddLightningDataTable < ActiveRecord::Migration
  def change
    create_table :lightningdata do |t|
      t.integer :user_id
      t.integer :lightning_id
      t.timestamps
    end
  end
end
