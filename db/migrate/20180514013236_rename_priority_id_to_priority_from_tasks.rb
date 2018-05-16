class RenamePriorityIdToPriorityFromTasks < ActiveRecord::Migration[5.1]
  def change
    rename_column :tasks, :priority_id, :priority
  end
end
