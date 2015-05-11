class Admin::GoodsController < AdminController
  before_filter :get_good, only: [:show, :update, :destroy]

  def index
    @goods = Good.all
  end

  def new
    @good = Good.new
  end

  def create
  end

  def show
  end

  def update
  end

  def destroy
    good.destroy
    respond_to do |format|
      format.html { redirect_to admin_goods_url }
      format.json { head :no_content }
    end
  end

  protected

  def good
    @good
  end

  def get_good
    @good = Good.find_by(id:params[:id])
  end
end
