class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :likes, as: :likeable

  def liked?
    if likes.user_id.include?(current_user.id)
      return true
    else
      return false
    end
  end
end
