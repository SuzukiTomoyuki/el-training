class ChangeElementUserIdToIntFromTasks < ActiveRecord::Migration[5.1]
  def change
    remove_column :tasks, :user_id, :string
    add_column :tasks, :user_id, :integer
  end
end
