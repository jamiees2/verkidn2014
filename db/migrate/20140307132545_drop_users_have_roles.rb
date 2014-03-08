class DropUsersHaveRoles < ActiveRecord::Migration
  def up
    drop_table :roles_users
    add_column :users, :role_id, :integer
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
