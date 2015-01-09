class AddLastuservotedToLightning < ActiveRecord::Migration
  def change
    add_column :lightningdata, :userhasvoted, :boolean, default: false
  end
end
