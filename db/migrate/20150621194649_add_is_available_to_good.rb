class AddIsAvailableToGood < ActiveRecord::Migration
  def change
    add_column :goods, :is_available, :boolean, default: true
  end
end
