class AddLightningNextToUser < ActiveRecord::Migration
  def change
    add_column :users, :nextlightning, :string, default: "play"
  end
end
