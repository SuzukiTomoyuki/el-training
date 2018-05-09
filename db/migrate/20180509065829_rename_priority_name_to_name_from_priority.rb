class RenamePriorityNameToNameFromPriority < ActiveRecord::Migration[5.1]
  def change
    rename_column :priorities, :priority_name, :name
  end
end
