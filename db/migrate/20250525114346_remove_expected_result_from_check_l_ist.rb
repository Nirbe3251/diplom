class RemoveExpectedResultFromCheckLIst < ActiveRecord::Migration[7.0]
  def up
    remove_column :checklists, :expected_result
  end

  def down
    add_column :checklists, :expected_result, :string, nill: false
  end
end
