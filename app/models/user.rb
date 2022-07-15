class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i[facebook google_oauth2]

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  has_many :requests, dependent: :destroy
  has_many :requested_friends, through: :requests

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :first_name, :last_name, :email, presence: true

  before_create do
    self.notification_view = DateTime.now
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.first_name = auth.info.name.split.first
      user.last_name = auth.info.name.split.last
    end
  end

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

  def requesting_friends
    User.all.select { |user| user.requested_friends.include?(self) }
  end

  def not_friends_or_pending
    User.all.select{ |user| friends.exclude?(user) && user != self && requested_friends.exclude?(user) && requesting_friends.exclude?(user)}
  end

  def friend?(user)
    friends.include?(user)
  end

  def requested_friend?(user)
    requested_friends.include?(user)
  end

  def inbound_requests
    Request.all.select { |request| request.requested_friend_id == self.id }
  end

  def requesting_friend?(user)
    user.requested_friends.include?(self)
  end

  def not_friend_or_pending?(user)
    !friend?(user) && !requested_friend?(user) && !requesting_friend?(user)
  end

  # Request Notifications and separation by seen and unseen
  
  def new_requests
    inbound_requests.select { |request| request.created_at > notification_view }
  end

  def old_requests
    inbound_requests.select { |request| request.created_at <= notification_view }
  end

end
