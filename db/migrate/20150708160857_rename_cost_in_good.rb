class RenameCostInGood < ActiveRecord::Migration
  def change
    rename_column :goods, :cost, :cost_usd
  end
end
