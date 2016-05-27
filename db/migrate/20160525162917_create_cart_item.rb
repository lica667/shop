class CreateCartItem < ActiveRecord::Migration
  def change
    create_table :cart_items do |t|
      t.integer :cart_id
      t.integer :good_id
      t.integer :quantity
    end
  end
end
