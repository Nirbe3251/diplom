class RemoveLimitForSeverityTitle < ActiveRecord::Migration[7.0]
  def up
    change_column :severities, :title, :string, limit: nil
    change_column :priorities, :title, :string, limit: nil
  end

  def down
    change_column :severities, :title, :string, limit: 10
    change_column :priorities, :title, :string, limit: 10
  end
end
