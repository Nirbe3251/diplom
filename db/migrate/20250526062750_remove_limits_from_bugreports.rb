class RemoveLimitsFromBugreports < ActiveRecord::Migration[7.0]
  def up
    change_column :bug_reports, :title, :string, limit: 100
    change_column :bug_reports, :description, :text, limit: 300
  end

  def down
    change_column :bug_reports, :title, :string, limit: 50
    change_column :bug_reports, :description, :text, limit: 40
  end
end
