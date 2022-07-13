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
  has_many :frienders, through: :invitations

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  def full_name
    "#{first_name} #{last_name}"
  end

  def age
    now = Time.now.utc.to_date
    now.year - birthdate.year - ((now.month > birthdate.month || (now.month == birthdate.month && now.day >= birthdate.day)) ? 0 : 1)
  end

  def not_friends
    User.all.select { |user| friends.exclude?(user)  && user != self }
  end

  def not_friends_or_pending
    User.all.select{ |user| friends.exclude?(user) && user != self && requested_friends.exclude?(user) && frienders.exclude?(user)}
  end
end
