class ShopController < ApplicationController
  def index
    @goods = Good.available
  end

  def category
  	@goods = params[:id] ? Category.find_by(id: params[:id]).goods : @goods = Good.all
    render 'index'
  end

  def show
    @good = Good.find_by(id: params[:id])
  end

  def categories
    respond_to do |format|
      format.json { render json: { categories: Category.category_presenter } }
    end
  end

  def add_to_cart
    @current_user = Session.find_by(session_id: cookies['_shop_session'])
    # we shoul sell only by BY currency :(
    @cart = @current_user.cart || @current_user.build_cart(currency: 'BY')
    respond_to do |format|
      if @cart.add_item!(cart_params)
        format.json { render json: { status: :ok, cart_total: @cart.total } }
      else
        format.json { render json: { status: :failed } }
      end
    end
  end

  def change_currency
    if !params[:token].nil? && !params[:id].nil?
      @good = Good.find_by(id: params[:id])
      if @good
        return render json: { status: :ok, cost: @good.price(params[:token]), id: params[:id] }
      else
        return render json: { status: :error, message: "No good with id" }
      end
    end
  end

  protected
  def cart_params
    params.permit(:good_id, :quantity)
  end
end
