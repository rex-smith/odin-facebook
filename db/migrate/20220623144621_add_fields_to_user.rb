class AddFieldsToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string
    add_column :users, :birthdate, :date
    add_column :users, :gender, :string
    add_column :users, :address, :string
    add_column :users, :phonenumber, :string
  end
end
