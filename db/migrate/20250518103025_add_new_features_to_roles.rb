class AddNewFeaturesToRoles < ActiveRecord::Migration[7.0]
  def up
    add_column :roles, :edit_test_case, :integer, default: 0
    add_column :roles, :edit_checklist, :integer, default: 0
    add_column :roles, :edit_test_plan, :integer, default: 0
    add_column :roles, :edit_bug_report, :integer, default: 0

    add_column :roles, :remove_test_case, :integer, default: 0
    add_column :roles, :remove_checklist, :integer, default: 0
    add_column :roles, :remove_test_plan, :integer, default: 0
    add_column :roles, :remove_bug_report, :integer, default: 0
  end

  def down
    remove_column :roles, :edit_test_case
    remove_column :roles, :edit_checklist
    remove_column :roles, :edit_test_plan
    remove_column :roles, :edit_bug_report

    remove_column :roles, :remove_test_case
    remove_column :roles, :remove_checklist
    remove_column :roles, :remove_test_plan
    remove_column :roles, :remove_bug_report
  end
end
