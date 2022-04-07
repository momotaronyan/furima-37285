class OrdersController < ApplicationController
  before_action :id_get, only: [:index, :create]
  def index
    @order_shipping = OrderShipping.new
  end

  def new
  end

  def create
    @order_shipping = OrderShipping.new(order_params)
    if @order_shipping.valid?
      @order_shipping.save
      return redirect_to root_path
    else
      render 'index'
    end
  end

  private

  def order_params
    params.require(:order_shipping).permit(:post_code, :prefecture_id, :municipality, :address, :building, :phone_number).merge(user_id: current_user.id, item_id: @item.id, token: params[:token])
  end

  def id_get
    @item = Item.find(params[:item_id])
  end
end
