class Task < ApplicationRecord
  has_many :task_labels, dependent: :destroy
  has_many :labels, through: :task_labels
  has_many :group_tasks, dependent: :destroy
  has_many :groups, through: :group_tasks
  belongs_to :holder, class_name: 'User', foreign_key: 'user_id'
  belongs_to :user
  belongs_to :charge_user, class_name: 'User'
  # after_save :create_labels
  # before_update :create_labels
  after_create :create_labels

  validate :validate_caption_error, :check_caption_empty

  enum priority:{
      high: 0,
      middle: 1,
      low: 2
  }

  enum status:{
      done: 0,
      doing: 1,
      to_do: 2
  }

  # scope :get_by_caption, ->(caption) {
  #   where("caption like ?", "%#{caption}%")
  # }

  # 三種類全部作っとく
  scope :get_by_status, ->(status) {
    where(status: status)
  }

  scope :status_to_do, -> {
    where(status: to_do)
  }

  scope :status_doing, -> {
    where(status: doing)
  }

  scope :status_done, -> {
    where(status: done)
  }

  scope :not_status_done, -> {
    where.not(status: done)
  }

  def validate_caption_error
    if caption.length > 100
      errors.add(:caption, "が100文字を超えている")
    end
  end

  def check_caption_empty
    if caption.empty?
      errors.add(:caption, "ない")
    end
  end


  def create_labels
    self.task_labels.each do |label|
      Label.where(id: label.label_id).destroy_all
    end
    label.gsub(/(\s|　)+/, ' ').split(" ").each do | label_name |
      label_id = Label.find_or_create_by(name: label_name)
      self.task_labels.find_or_create_by(label: label_id)
    end
  end

  def link_group

  end

end
