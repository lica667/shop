class CartItem < ActiveRecord::Base
	belongs_to :cart
	belongs_to :good

  def total
    quantity * good.price(cart.currency)
  end
end
