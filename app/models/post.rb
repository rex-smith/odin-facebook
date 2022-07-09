class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable
  has_many :likes, as: :likeable

  def liked?
    if likes.user_id.include?(current_user.id)
      return true
    else
      return false
    end
  end
end
