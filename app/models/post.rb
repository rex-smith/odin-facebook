class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable
  has_many :likes, as: :likeable

  validates :title, presence: true
  validate :has_body_or_photo?
  has_one_attached :photo

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

  private

  def has_body_or_photo?
    unless !body.empty? || photo.attached?
      errors.add(:base, :blank, message: 'Please add commentary or a photo to your post.')
    end
  end

end
