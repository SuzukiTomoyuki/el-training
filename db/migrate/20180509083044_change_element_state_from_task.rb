class ChangeElementStateFromTask < ActiveRecord::Migration[5.1]
  def change
    change_column :tasks, :state, :integer
  end

end
