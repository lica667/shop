class AddGoodIdToPhoto < ActiveRecord::Migration
  def change
    add_column :photos, :good_id, :integer
  end
end
