class AddRoles < ActiveRecord::Migration[7.0]
  def up
    create_table :roles do |t|
      t.string :name, null: false, limit: 45
      t.integer :create_test_case, default: 0
      t.integer :create_check_list, default: 0
      t.integer :create_test_plan, default: 0
      t.integer :create_bug_report, default: 0
    end
  end

  def down
    drop_table :roles
  end
end
