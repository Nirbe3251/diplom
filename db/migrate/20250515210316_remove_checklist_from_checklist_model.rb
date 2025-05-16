class RemoveChecklistFromChecklistModel < ActiveRecord::Migration[7.0]
  def up
    remove_column :checklists, :test_module
    remove_column :checklists, :checklist
  end

  def down
    add_column :checklists, :checklist, :string
    add_column :checklists, :test_module, :string
  end
end
