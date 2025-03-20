class ProjectUsers < ActiveRecord::Migration[7.0]
  def up
    create_table :project_users do |t|
      t.belongs_to :project, null: false
      t.belongs_to :user, null: false
    end
  end

  def down
    drop_table :project_users
  end
end
