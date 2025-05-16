class AddTestModulesToChecklist < ActiveRecord::Migration[7.0]
  def up
    create_table :checklist_modules do |t|
      t.string :name, null: false
      t.integer :position, null: false, default: 1, validates: { minimum: 1 }

      t.belongs_to :checklist
    end

    create_table :module_checks do |t|
      t.integer :position, null: false, default: 1, validates: { minimum: 1 }
      t.text :module_step, null: false
      t.belongs_to :checklist_module
    end
  end

  def down
    drop_table :checklist_modules
    drop_table :module_checks
  end
end
