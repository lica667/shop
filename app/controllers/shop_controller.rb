class ShopController < ApplicationController
  def index
    @goods = Good.all
  end
end
