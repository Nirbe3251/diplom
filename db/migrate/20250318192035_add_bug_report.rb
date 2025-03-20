class AddBugReport < ActiveRecord::Migration[7.0]
  def up
    create_table :bug_reports do |t|
      t.text :description, null: false, limit: 45
      t.text :full_description, limit: 500
      t.text :steps, limit: 300
      t.string :environment, limit: 150
      t.text :comment, limit: 500

      t.belongs_to :project
      t.belongs_to :severity
      t.belongs_to :priority
      t.belongs_to :status
    end
  end

  def down
    drop_table :bug_reports
  end
end
