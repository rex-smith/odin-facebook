class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  has_many :requests, dependent: :destroy
  has_many :requested_friends, through: :requests

  has_many :invitations
  has_many :frienders, through: :requests

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  def full_name
    "#{first_name} #{last_name}"
  end
end
