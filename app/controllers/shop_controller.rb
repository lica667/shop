class ShopController < ApplicationController
  def index
    @goods = Good.all
  end

  def category
  	if params[:id]
  		@goods = Category.find_by(params[:id]).goods
  	else
  		@goods = Good.all
  	end
  end
end
