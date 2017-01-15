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

  def order
    @user = @cart.user || User.find_by(email: params[:user][:email]) || User.create(user_params)
    @order = @user.orders.create
    address = Address.find_by(address_params) || @user.addresses.build(address_params)
    @order.address = address
    @order.cart_items = @cart.cart_items 

    respond_to do |format|
      if @cart.save
        @cart.delete
        @order.save
        format.html { redirect_to users_orders_url }
      else
        format.html { render action: :checkout }
      end
    end
  end

  protected
  def cart_params
    params.require(:cart).permit(cart_items_attributes: [:id, :quantity])
  end

  def user_params
    params.require(:user).permit(:name, :email, :phone).merge(password:'password')
  end

  def address_params
    params.require(:address).permit(:address, :city)
  end
end
