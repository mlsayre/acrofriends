class AddLightningLifetimeDataToUser < ActiveRecord::Migration
  def change
  	add_column :users, :lifetimelightningthumbsup, :integer, default: 0
  	add_column :users, :lifetimelightningthumbsdown, :integer, default: 0
  	add_column :users, :lifetimelightninghearts, :integer, default: 0
  	add_column :users, :lifetimelightningsplayed, :integer, default: 0
  	add_column :users, :lifetimelightningthumbsupgiven, :integer, default: 0
  	add_column :users, :lifetimelightningthumbsdowngiven, :integer, default: 0
  	add_column :users, :lifetimelightningheartsgiven, :integer, default: 0
  	add_column :lightnings, :thumbsup, :integer, default: 0
  	add_column :lightnings, :thumbsdown, :integer, default: 0
  	add_column :lightnings, :hearts, :integer, default: 0
  end
end
