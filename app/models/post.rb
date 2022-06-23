class Post < ApplicationRecord
  belongs_to :user
  has_mamy :comments, as: :commentable
  has_many :likes, as: :likeable
end
