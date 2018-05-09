class RenameStatToStatusIdFromTask < ActiveRecord::Migration[5.1]
  def change
    rename_column :tasks, :state, :status_id
  end
end
