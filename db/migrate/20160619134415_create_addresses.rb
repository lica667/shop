class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :address
      t.string :city
      t.integer :user_id

      t.timestamps
    end
  end
end
