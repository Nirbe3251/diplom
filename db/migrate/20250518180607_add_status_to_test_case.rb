class AddStatusToTestCase < ActiveRecord::Migration[7.0]
  def up
    create_table :test_case_statuses do |t|
      t.boolean :completed

      t.belongs_to :release
      t.string :test_case_id, index: true, foreign_key: true
    end
  end

  def down
    drop_table :test_case_statuses
  end
end
