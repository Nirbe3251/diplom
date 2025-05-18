class AddNewFeaturesToRoles < ActiveRecord::Migration[7.0]
  def up
    add_column :roles, :edit_test_case, :boolean
    add_column :roles, :edit_checklist, :boolean
    add_column :roles, :edit_test_plan, :boolean
    add_column :roles, :edit_bug_report, :boolean

    add_column :roles, :remove_test_case, :boolean
    add_column :roles, :remove_checklist, :boolean
    add_column :roles, :remove_test_plan, :boolean
    add_column :roles, :remove_bug_report, :boolean
  end

  def down
    remove_column :roles, :edit_test_case
    remove_column :roles, :edit_checklist
    remove_column :roles, :edit_test_plan
    remove_column :roles, :edit_bug_report

    remove_column :roles, :remove_test_case
    remove_column :roles, :remove_edit_checklist
    remove_column :roles, :remove_edit_test_plan
    remove_column :roles, :remove_edit_bug_report
  end
end
