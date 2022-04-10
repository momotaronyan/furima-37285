class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :id_get, only: [:index, :create]
  before_action :return_to_root, only: [:index, :create]
  def index
    @order_shipping = OrderShipping.new
  end

  def new
  end

  def create
    @order_shipping = OrderShipping.new(order_params)
    if @order_shipping.valid?
      @order_shipping.save
      pay_item
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

  def pay_item
    Payjp.api_key = "sk_test_baf8fd503e9c2a887942dbfc"
    Payjp::Charge.create(
      amount: Item.find(params[:item_id]).price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end
  
  private
  def return_to_root
    if @item.order || current_user.id = @item.user.id
      redirect_to root_path
    end
  end
end
