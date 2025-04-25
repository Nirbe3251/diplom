class AddStepsToBugReportStatus < ActiveRecord::Migration[7.0]
  def up
    add_column :status_bug_reports, :step, :integer, null: false
  end

  def down
    remove_column :status_bug_reports, :step
  end
end
