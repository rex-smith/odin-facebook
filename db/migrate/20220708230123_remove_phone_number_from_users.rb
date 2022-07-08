class RemovePhoneNumberFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :phonenumber
  end
end
