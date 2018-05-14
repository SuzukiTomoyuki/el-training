class Task < ApplicationRecord

  validate :add_caption_error, :check_caption_empty

  enum priority_id:{
      high: 0,
      middle: 1,
      low: 2
  }

  # idはだめ
  enum status_id:{
      done: 0,
      doing: 1,
      to_do: 2
  }

  scope :get_by_caption, ->(caption) {
    where("caption like ?", "%#{caption}%")
  }

  scope :get_by_status_id, ->(status_id) {
    where(status_id: status_id)
  }

  # searchを作る

  # validate_caption_error   ここの機能の名前にちなんで
  def add_caption_error
    if caption.length > 100
      errors.add(:caption, "が100文字を超えている")
    end
  end

  def check_caption_empty
    if caption.empty?
      errors.add(:caption, "ない")
    end
  end

end
