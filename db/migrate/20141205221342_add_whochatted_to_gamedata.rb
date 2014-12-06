class AddWhochattedToGamedata < ActiveRecord::Migration
  def change
    add_column :gamedata, :whochatted, :string, default: ""
  end
end
