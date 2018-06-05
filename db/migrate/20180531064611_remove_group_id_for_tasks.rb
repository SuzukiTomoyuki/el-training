class RemoveGroupIdForTasks < ActiveRecord::Migration[5.1]
  def change
    remove_column :tasks, :group_id
  end
end
