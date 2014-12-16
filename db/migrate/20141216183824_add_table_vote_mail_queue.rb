class AddTableVoteMailQueue < ActiveRecord::Migration
  def change
    create_table :votemailqueue do |t|
      t.integer :user_id
      t.integer :game_id
      t.datetime :playendtime
      t.timestamps
    end
  end
end
