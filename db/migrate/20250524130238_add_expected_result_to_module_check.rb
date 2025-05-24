class AddExpectedResultToModuleCheck < ActiveRecord::Migration[7.0]
  def up
    add_column :module_checks, :expected_result, :string
  end

  def down
    remove_column :module_checks, :expected_result
  end
end
