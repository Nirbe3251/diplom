class AddStatusBugReport < ActiveRecord::Migration[7.0]
  def up
    create_table :status_bug_reports do |t|
      t.string :title, limit: 10
    end
  end

  def down
    drop_table :status_bug_reports
  end
end
