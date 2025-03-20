class AddPriority < ActiveRecord::Migration[7.0]
  def up
    create_table :priorities do |t|
      t.string :title, limit: 10
    end
  end

  def down
    drop_table :priorities
  end
end
