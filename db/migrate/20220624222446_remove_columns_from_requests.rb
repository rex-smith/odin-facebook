class RemoveColumnsFromRequests < ActiveRecord::Migration[7.0]
  def change
    remove_column :requests, :friendee_id
    remove_column :requests, :friender_id
    add_reference :requests, :user, foreign_key: true, index: true
    add_reference :requests, :requested_friend, foreign_key: {to_table: :users}, index: true
  end
end
