class RenameStatusIdToStatusFromTask < ActiveRecord::Migration[5.1]
  def change
    rename_column :tasks, :status_id, :status
  end
end
