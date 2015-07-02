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
end
