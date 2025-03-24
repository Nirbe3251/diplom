class AddProjects < ActiveRecord::Migration[7.0]
  def up
    create_table :projects do |t|
      t.string :title, null: false, index: true
      t.text :description, null: true, limit: 5000
      t.belongs_to :user, null: false, index: true
      t.datetime :start_at, null: false
      t.datetime :end_at
    end
  end

  def down
    drop_table :projects
  end
end
