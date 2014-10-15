class CreateGamedata < ActiveRecord::Migration
  def change
    create_table :gamedata do |t|
      t.integer :game_id
      t.integer :user_id
      t.string :r1answer
      t.string :r2answer
      t.string :r3answer
      t.string :r4answer
      t.integer :gamepoints
      t.boolean :r1voted
      t.boolean :r2voted
      t.boolean :r3voted
      t.boolean :r4voted

      t.timestamps
    end
  end
end
