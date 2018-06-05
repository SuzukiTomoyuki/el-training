class AddGroupIdForTasks < ActiveRecord::Migration[5.1]
  def change
    add_column :tasks, :group_id, :integer, default: 0
  end
end
