class AddReleases < ActiveRecord::Migration[7.0]
  def up
    create_table :releases do |t|
      t.string :name

      t.belongs_to :project
    end
  end

  def down
    drop_table :releases
  end
end
