class AddProjects < ActiveRecord::Migration[7.0]
  def up
    create_table :projects do |t|
      t.string :name, null: false, index: true
      t.belongs_to :user, null: false, index: true
      t.timestamps
    end
  end

  def down
    drop_table :projects
  end
end
