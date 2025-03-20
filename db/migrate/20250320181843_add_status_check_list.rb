class AddStatusCheckList < ActiveRecord::Migration[7.0]
  def up
    create_table :status_checklists do |t|
      t.boolean :completed, default: false
    end
  end

  def down
    drop_table :status_checklists
  end
end
