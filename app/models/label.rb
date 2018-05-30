class Label < ApplicationRecord
  has_many :task_labels, dependent: :destroy
  has_many :labels, through: :task_labels
end
