class AddGameChats < ActiveRecord::Migration
  def change
    create_table :gamechats do |t|
      t.string :message
      t.integer :user_id
      t.integer :game_id

      t.timestamps
    end
  end
end
