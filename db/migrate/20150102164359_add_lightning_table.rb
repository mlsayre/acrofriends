class AddLightningTable < ActiveRecord::Migration
  def change
    create_table :lightning do |t|
      t.integer :user_id
      t.string :letters
      t.string :category
      t.integer :votes
      t.boolean :thumbsup
      t.timestamps
    end
  end
end
