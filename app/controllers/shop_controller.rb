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
    root_categories = Array.new()
    Category.root.each { |c| root_categories <<  CategoryPresenter.new(c).present}
    respond_to do |format|
      format.json { render json: { categories: root_categories } }
    end
  end
end
