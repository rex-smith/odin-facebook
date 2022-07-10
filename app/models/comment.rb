class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :likes, as: :likeable

  def liked?(user)
    likes.each do |like|
      if like.user_id == user.id
        return true
      end
    end
    return false
  end
end
