class CartItemController < ApplicationController

  def destroy
    @cart_item = @cart.cart_items.find(params[:id])
    @cart_item.destroy
    @id = params[:id]
    @cart_total = @cart.total
    respond_to do |format|
      format.js { render :destroy }
    end
  end
  
  
end