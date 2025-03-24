class AddChecklists < ActiveRecord::Migration[7.0]
  def up
    create_table :checklists do |t|
      t.text :head, null: false, limit: 100
      t.text :checklist, null: false, limit: 10_000
      t.string :expected_result, null: false, limit: 100
      t.string :test_module, limit: 25
      t.string :test_type, limit: 200

      t.belongs_to :status, null: false, default: 0
      t.belongs_to :project
    end
  end

  def down
    drop_table :checklists
  end
end
