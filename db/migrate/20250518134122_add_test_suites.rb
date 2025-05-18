class AddTestSuites < ActiveRecord::Migration[7.0]
  def up
    create_table :test_suites do |t|
      t.string :title, null: false
    end
  end

  def down
    drop_table :test_suites
  end
end
