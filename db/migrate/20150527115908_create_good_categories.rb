class CreateGoodCategories < ActiveRecord::Migration
  def change
    create_table :good_categories do |t|
      t.integer :good_id
      t.integer :category_id

      t.timestamps
    end
  end
end
