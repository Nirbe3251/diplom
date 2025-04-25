class AddPerformerToBugreport < ActiveRecord::Migration[7.0]
  def up
    add_column :bug_reports, :performer_id, :integer
    add_column :bug_reports, :title, :string, limit: 50
  end

  def down
    remove_column :bug_reports, :performer_id
    remove_column :bug_reports, :title
  end
end
