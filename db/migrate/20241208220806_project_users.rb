class ProjectUsers < ActiveRecord::Migration[7.0]
  def up
    create_table :project_users do |t|
      t.integer :project_id, null: false
      t.integer :user_id, null: false
      t.timestamps
    end
  end

  def down
    drop_table :project_users
  end
end
