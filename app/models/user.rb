class User < ActiveRecord::Base
  # バリデーションの追加
  before_save { self.email = self.email.downcase }
  #nameは空でなく、また、MAX50文字
  validates :name, presence: true, length: { maximum: 50 }
  #メールアドレスの正規表現パターンを定義
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  #emailは空でなく、255文字以内
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  #countryは空でなく、また、MAX30文字
  # on: :update do not have to be set at first
  validates :country, presence: true, length: { maximum: 30 }, on: :update
  #animalは空でなく、また、MAX30文字
  validates :animal, presence: true, length: { maximum: 30 }, on: :update
  # 8.2 ユーザーと投稿の関連づけ 
  # 1 user can have many posts yet each post only belongs to 1 user
  has_many :microposts
end