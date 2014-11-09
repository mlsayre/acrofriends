class AddTooltipsToUser < ActiveRecord::Migration
  def change
    add_column :users, :tooltips, :boolean, default: true
  end
end
