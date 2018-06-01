class GroupUser < ApplicationRecord
  belongs_to :group
  belongs_to :user, optional: true
end
