class RemoveInvitations < ActiveRecord::Migration[7.0]
  def up
    drop_table :invitations
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
