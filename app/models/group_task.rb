class GroupTask < ApplicationRecord
  belongs_to :group
  belongs_to :task

  # enum でもっとうまくやる
  scope :group_user_tasks, -> (group_id, user_id, status_id) {
    where(group_id: group_id).where(task_id: Task.where(charge_user_id: user_id).where(status: status_id).ids)
  }
end
