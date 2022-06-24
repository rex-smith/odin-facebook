class CreateInvitations < ActiveRecord::Migration[7.0]
  def change
    create_table :invitations do |t|
      t.references :user, index: true, foreign_key: true
      t.references :friender, index: true, foreign_key: {to_table: :users}
      t.timestamps
    end
  end
end
