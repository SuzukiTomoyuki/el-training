class Group < ApplicationRecord
  has_many :group_tasks, dependent: :destroy
  has_many :group_users, dependent: :destroy
  has_many :tasks, through: :group_tasks
  has_many :users, through: :group_users
  accepts_nested_attributes_for :group_tasks
  accepts_nested_attributes_for :group_users
  validate :validate_name_error

  def validate_name_error
    if name.empty?
      errors.add(:name, "グループ名を入力してください")
    end
  end
end
