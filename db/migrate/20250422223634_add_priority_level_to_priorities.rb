class AddPriorityLevelToPriorities < ActiveRecord::Migration[7.0]
  def up
    add_column :priorities, :priority_level, :integer, null: false
  end

  def down
    remove_column :priorities, :priority_level
  end
end
