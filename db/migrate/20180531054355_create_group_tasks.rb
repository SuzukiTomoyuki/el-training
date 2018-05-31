class CreateGroupTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :group_tasks do |t|
      t.references :group, foreign_key: true
      t.references :task, foreign_key: true

      t.timestamps
    end
  end
end
