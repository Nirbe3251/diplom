class AddTestPlan < ActiveRecord::Migration[7.0]
  def up
    create_table :test_plans do |t|
      t.text :title, null: false
      t.text :purpose, null: false
      t.text :features_to_be_tested
      t.text :features_not_to_be_tested
      t.text :test_strategy
      t.text :test_approach
      t.text :criteria
      t.text :resources
      t.datetime :test_schedule
      t.text :roles_and_responsibility
      t.text :risk_evaluation
      t.text :documentation
      t.text :metrics

      belongs_to :project
    end
  end

  def down
    drop_table :test_plans
  end
end
