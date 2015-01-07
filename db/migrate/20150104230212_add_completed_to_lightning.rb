class AddCompletedToLightning < ActiveRecord::Migration
  def change
    add_column :lightnings, :completed, :boolean, default: false
  end
end
