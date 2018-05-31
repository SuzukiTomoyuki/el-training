class GroupTask < ApplicationRecord
  belongs_to :group_id
  belongs_to :task_id
end
