class Task < ApplicationRecord

  # validates :caption, length: { maximum: 100 }
  validate :add_caption_error, :check_caption_empty

  enum priority_id:{
      high: 0,
      middle: 1,
      low: 2
  }

  enum status_id:{
      done: 0,
      doing: 1,
      to_do: 2
  }

  def add_caption_error
    if caption.length > 100
      errors.add(:caption, "が100文字を超えている")
    end
  end

  def check_caption_empty
    if caption.empty?
      errors.add(:caption, "が無い。何も無い。")
    end
  end

end
