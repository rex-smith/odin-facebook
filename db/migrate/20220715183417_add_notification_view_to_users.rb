class AddNotificationViewToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :notification_view, :datetime
  end
end
