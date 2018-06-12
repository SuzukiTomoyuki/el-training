class AddColumnChargeTasks < ActiveRecord::Migration[5.1]
  def change
    add_column :tasks, :charge_user_id, :integer, default: 0
  end
end
