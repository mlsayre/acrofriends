class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :r1letters
      t.string :r2letters
      t.string :r3letters
      t.string :r4letters
      t.string :r1cat
      t.string :r2cat
      t.string :r3cat
      t.string :r4cat
      t.string :name

      t.timestamps
    end
  end
end
