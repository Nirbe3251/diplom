class AddLevelToSeverity < ActiveRecord::Migration[7.0]
  def up
    add_column :severities, :severity_level, :integer, null: false, default: 0
  end

  def down
    remove_column :severities, :severity_level
  end
end
