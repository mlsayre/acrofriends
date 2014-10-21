class AddShowadsToUser < ActiveRecord::Migration
  def change
    add_column :users, :showads, :boolean, default: true
  end
end
