class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :address_id
      t.integer :user_id
      t.integer :status

      t.timestamps
    end
  end
end