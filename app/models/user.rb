class User < ActiveRecord::Base
  # バリデーションの追加
  before_save { self.email = self.email.downcase }
  #nameは空でなく、また、最大50文字になる
  validates :name, presence: true, length: { maximum: 50 }
  #メールアドレスの正規表現パターンを定義
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  #emailは空でなく、255文字以内
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  #countryは空でなく、また、最大30文字になる
  validates :country, presence: true, length: { maximum: 30 }
  #animalは空でなく、また、最大30文字になる
  validates :animal, presence: true, length: { maximum: 30 }
end