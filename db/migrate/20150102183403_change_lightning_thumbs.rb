class ChangeLightningThumbs < ActiveRecord::Migration
  def change
    remove_column :lightning, :thumbsup
    add_column :lightningdata, :thumbsup, :boolean
  end
end
