class SetPriorityIdToTask < ActiveRecord::Migration[5.1]
  def change
    remove_column :tasks, :priority, :string
    add_column :tasks, :priority, :integer
  end

end
