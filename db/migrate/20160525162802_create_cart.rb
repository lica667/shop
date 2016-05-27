class CreateCart < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.integer :session_id
      t.string  :currency
    end
  end
end
