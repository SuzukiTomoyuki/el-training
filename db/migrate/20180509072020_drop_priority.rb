class DropPriority < ActiveRecord::Migration[5.1]
  def change
    drop_table :priorities
  end
end
