class AddChartDataToRelease < ActiveRecord::Migration[7.0]
  def up
    add_column :releases, :chart_data, :string
  end

  def down
    remove_column :realeases, :chart_data
  end
end
