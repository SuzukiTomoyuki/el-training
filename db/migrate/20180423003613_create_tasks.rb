class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.string :priority
      t.string :state
      t.datetime :deadline
      t.datetime :update_time
      t.string :label
      t.string :caption

      t.timestamps
    end
  end
end
