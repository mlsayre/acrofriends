class AddCommentsToLightningData < ActiveRecord::Migration
  def change
    add_column :lightningdata, :comment, :string, default: ""
    add_column :lightningdata, :commenttime, :datetime
  end
end
