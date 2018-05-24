class Label < ApplicationRecord
  has_many :task_labels
  has_many :labels, through: :task_labels
end
