class AddEmailsentToGamedata < ActiveRecord::Migration
  def change
    add_column :gamedata, :voteemailsent, :boolean, default: false
  end
end
