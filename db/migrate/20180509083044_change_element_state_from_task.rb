class ChangeElementStateFromTask < ActiveRecord::Migration[5.1]
  def change
    remove_column :tasks, :state, :string
    add_column :tasks, :state, :integer
  end
end
