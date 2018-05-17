class User < ApplicationRecord
  # has_secure_password
  validates :name,
    uniqueness: {
      message: "とメールアドレスが同じ組み合わせのユーザが既に存在します。",
      scope: [:email]
  }
  validate :check_empty

  def check_empty
    if pass.empty?
      errors.add(:pass, "を入力してください")
    end
    if email.empty?
      errors.add(:email, "を入力してください")
    end
    if name.empty?
      errors.add(:name, "を入力してください")
    end
  end

end