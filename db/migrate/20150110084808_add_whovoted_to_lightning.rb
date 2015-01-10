class AddWhovotedToLightning < ActiveRecord::Migration
  def change
    add_column :lightnings, :whovoted, :string, default: ""
    add_column :lightnings, :whocommented, :string, default: ""
  end
end
