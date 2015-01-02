class AddAnswerToLightning < ActiveRecord::Migration
  def change
    add_column :lightnings, :answer, :string, default: ""
  end
end
