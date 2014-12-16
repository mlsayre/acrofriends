class ChangeVotemailqueueName < ActiveRecord::Migration
  def change
    rename_table :votemailqueue, :votemailqueues
  end
end
