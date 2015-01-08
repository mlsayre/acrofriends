class AddHeartToLightdata < ActiveRecord::Migration
  def change
    add_column :lightningdata, :heart, :boolean, default: false
  end
end
