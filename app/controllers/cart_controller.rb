class CartController < ApplicationController
  def index
  end

  def recalculate
    @cart.assign_attributes(cart_params)
    if @cart.save
      redirect_to checkout_cart_index_url and return if params[:checkout]
      redirect_to cart_index_url
    else
      redirect_to cart_index_url
    end
  end

  def checkout
    
  end

  def update
    binding.pry
  end

  protected
  def cart_params
    params.require(:cart).permit(cart_items_attributes: [:id, :quantity])
  end
end