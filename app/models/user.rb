class User < ApplicationRecord
  # mount_uploader :image_name, PictureUploader
  attr_accessor :image
  has_many :tasks, dependent: :destroy

  has_secure_password
  validates :name,
    uniqueness: {
      message: "とメールアドレスが同じ組み合わせのユーザが既に存在します。",
      scope: [:email]
  }
  validate :check_empty

  enum admin:{
      admin: true,
      common: false
  }

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def check_empty
    # if password.empty?
    #   errors.add(:password, "を入力してください")
    # end
    if email.empty?
      errors.add(:email, "を入力してください")
    end
    if name.empty?
      errors.add(:name, "を入力してください")
    end
  end

end