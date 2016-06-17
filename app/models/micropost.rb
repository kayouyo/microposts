class Micropost < ActiveRecord::Base
  belongs_to :user
  #   user_idが存在
  validates :user_id, presence: true
  #   contentが存在し、s文字数MAX140。
  validates :content, presence: true, length: { maximum: 140 }
end
