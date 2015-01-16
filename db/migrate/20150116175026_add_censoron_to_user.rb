class AddCensoronToUser < ActiveRecord::Migration
  def change
    add_column :users, :censoron, :boolean, default: true
  end
end
