class CreateCurrencies < ActiveRecord::Migration
  def change
    create_table :currencies do |t|
      t.decimal :eur_to_usd, precision: 8, scale: 2, default: 0.0
      t.decimal :usd_to_byn, precision: 8, scale: 2, default: 0.0

      t.timestamps
    end
  end
end
