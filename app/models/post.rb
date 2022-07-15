class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable
  has_many :likes, as: :likeable

  validates :body, :title, presence: true

  def liked?(user)
    likes.each do |like|
      if like.user_id == user.id
        return true
      end
    end
    return false
  end

  def find_like(user)
    return Like.where(user_id: user.id, likeable_id: self.id, likeable_tyle: "Post")
  end
end
