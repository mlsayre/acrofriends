class CreateChats < ActiveRecord::Migration
  def change
    create_table :chats do |t|
      t.string :message
      t.integer :user_id
      t.integer :group_id

      t.timestamps
    end
  end
end
