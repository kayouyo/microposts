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
  
  has_many :following_relationships, class_name:  "Relationship",
                                     foreign_key: "follower_id",
                                     dependent:   :destroy
  has_many :following_users, through: :following_relationships, source: :followed
  
  has_many :follower_relationships, class_name:  "Relationship",
                                    foreign_key: "followed_id",
                                    dependent:   :destroy
  has_many :follower_users, through: :follower_relationships, source: :follower
  
  # Follow other users
  def follow(other_user)
    following_relationships.find_or_create_by(followed_id: other_user.id)
  end

  # Unfollow following user
  def unfollow(other_user)
    following_relationship = following_relationships.find_by(followed_id: other_user.id)
    following_relationship.destroy if following_relationship
  end

  # want to follow the existing user？
  def following?(other_user)
    following_users.include?(other_user)
  end
end