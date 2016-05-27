class ShopController < ApplicationController
  def index
    @goods = Good.available
  end

  def category
  	if params[:id]
  		@goods = Category.find_by(id: params[:id]).goods
  	else
  		@goods = Good.all
  	end
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
    respond_to do |format|
      format.json { render json: { status: :ok } }
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
end
