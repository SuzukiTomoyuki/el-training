class RenamePriorityIdFromTask < ActiveRecord::Migration[5.1]
  def change
    rename_column :tasks, :priority, :priority_id
  end
end
