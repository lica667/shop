class Admin::OrdersController < AdminController

  def index
    @orders = Order.all
  end

  def change_state
    @order = Order.find_by(params[:order_id])
    @order.change_state!(params[:status].to_sym)
    redirect_to admin_orders_path
  end

end
