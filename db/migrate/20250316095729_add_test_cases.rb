class AddTestCases < ActiveRecord::Migration[7.0]
  def up
    create_table :test_cases, id: false do |t|
      t.string :id, null: false, unique: true
      t.string :title, null: false, limit: 45
      t.string :requirement, null: true, limit: 2048
      t.string :test_module, null: true, limit: 25
      t.text :test_data, null: true, limit: 150
      t.text :steps, null: false, limit: 300
      t.string :expected_result, null: false, limit: 100
      t.text :postconditions, null: true, limit: 150
      t.boolean :state

      t.belongs_to :priority
      t.belongs_to :project
      t.belongs_to :user, null: true
    end
  end

  def down
    drop_table :test_cases
  end
end
