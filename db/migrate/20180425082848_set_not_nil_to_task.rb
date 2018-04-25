class SetNotNilToTask < ActiveRecord::Migration[5.1]
  def change
    change_column :tasks, :priority, :string, null: false
    change_column :tasks, :state, :string, null: false
    change_column :tasks, :caption, :string, null: false
  end
end
