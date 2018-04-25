class RemoveUpdateTimeFromTask < ActiveRecord::Migration[5.1]
  def up
    remove_column :tasks, :update_time
  end

  def down
    add_column :tasks, :priority, :state, :deadline, :label, :caption
  end
end
