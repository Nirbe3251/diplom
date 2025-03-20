class AddRoleToUser < ActiveRecord::Migration[7.0]
  def up
    add_reference :users, :roles, null: true, foreign_key: true
  end

  def down
    remove_reference :users, :roles
  end
end
