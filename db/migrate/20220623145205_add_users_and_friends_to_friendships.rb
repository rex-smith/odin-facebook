class AddUsersAndFriendsToFriendships < ActiveRecord::Migration[7.0]
  def change
    add_reference :friendships, :user, foreign_key: true, index: true
    add_reference :friendships, :friend
  end
end
