# == Schema Information
#
# Table name: cart_items
#
#  id       :integer          not null, primary key
#  cart_id  :integer
#  good_id  :integer
#  quantity :integer
#  order_id :integer
#

class CartItem < ActiveRecord::Base
	belongs_to :cart
	belongs_to :good

  def total
    quantity * good.price(cart.currency)
  end
end
