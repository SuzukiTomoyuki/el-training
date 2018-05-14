class Task < ApplicationRecord

  validate :validate_caption_error, :check_caption_empty

  enum priority:{
      high: 0,
      middle: 1,
      low: 2
  }

  # idはだめ
  enum status:{
      done: 0,
      doing: 1,
      to_do: 2
  }

  scope :get_by_caption, ->(caption) {
    where("caption like ?", "%#{caption}%")
  }

  scope :get_by_status, ->(status) {
    where(status: status)
  }

  # searchを作る

  # validate_caption_error   ここの機能の名前にちなんで
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

end
