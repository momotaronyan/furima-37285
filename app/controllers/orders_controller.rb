class OrdersController < ApplicationController
  def index
  end

  def new
  end

  def create
    @item = Item.find(params[:id])
    @order = Order.create(order_params)
    Shipping.create(shipping_params)
    redirect_to root_path
  end

  private

  def order_params
    params.require(:order).permit().merge(user_id: current_user.id, item_id: @item.id)
  end

  def shipping_params
    params.require(:shipping).permit(:post_code, :prefecture_id, :municipality, :address, :building, :phone_number).merge(order_id: @order.id)
  end
end
