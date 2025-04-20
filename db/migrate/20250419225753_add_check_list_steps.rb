class AddCheckListSteps < ActiveRecord::Migration[7.0]
  def up
    create_table :checklist_steps do |t|
      t.belongs_to :checklist
      t.integer :position
      t.text :checklist_text
    end
  end

  def down
    drop_table :checklist_steps
  end
end
