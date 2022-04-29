class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :id_get, only: [:index, :create]
  before_action :return_to_root, only: [:index, :create]
  def index
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"] # 環境変数を読み込む
    card = Card.find_by(user_id: current_user.id) # ユーザーのid情報を元に、カード情報を取得
    #redirect_to new_card_path and return unless card.present?
    if card.present?
      customer = Payjp::Customer.retrieve(card.customer_token) # 先程のカード情報を元に、顧客情報を取得
      @card = customer.cards.first
    end
    @order_shipping = OrderShipping.new
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
    params.require(:order_shipping).permit(:post_code, :prefecture_id, :municipality, :address, :building, :phone_number).merge(user_id: current_user.id, item_id: @item.id)
  end

  def id_get
    @item = Item.find(params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    customer_token = current_user.card.customer_token
    Payjp::Charge.create(
      amount: Item.find(params[:item_id]).price,
      customer: customer_token,
      #card: order_params[:token],
      currency: 'jpy'
    )
  end
  
  private
  def return_to_root
    if @item.order || current_user.id == @item.user.id
      redirect_to root_path
    end
  end
end
