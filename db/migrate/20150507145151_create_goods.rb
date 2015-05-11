class CreateGoods < ActiveRecord::Migration
  def change
    create_table :goods do |t|
      t.string :name
      t.string :description
      t.decimal :cost, precision: 8, scale: 2, default: 0.0

      t.timestamps
    end
  end
end
