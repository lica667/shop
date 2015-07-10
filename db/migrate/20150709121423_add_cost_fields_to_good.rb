class AddCostFieldsToGood < ActiveRecord::Migration
  def change
    add_column :goods, :cost_eur, :decimal, precision: 8, scale: 2, default: 0.0
    add_column :goods, :cost_byr, :decimal, precision: 8, scale: 2, default: 0.0
  end
end
