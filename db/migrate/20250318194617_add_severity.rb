class AddSeverity < ActiveRecord::Migration[7.0]
  def up
    create_table :severities do |t|
      t.string :title, limit: 10
    end
  end

  def down
    drop_table :severities
  end
end
