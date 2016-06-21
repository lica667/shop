class AddStatusToCart < ActiveRecord::Migration
  def change
    add_column :carts, :status, :string
    add_column :carts, :address_id, :integer
  end
end
