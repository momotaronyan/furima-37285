class CardsController < ApplicationController

  def new
  end

  def create
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    customer = Payjp::Customer.create(
      description: 'test',
      card: params[:card_token]
    )
    card = Card.new(
      card_token: params[:card_token],
      customer_token: customer.id,
      user_id: current_user.id
    )
    if card.save
      flash[:notice] = "クレジットカードの登録が完了しました"
      redirect_to user_path(current_user)
    else
      flash[:alert] = "カード登録が完了しませんでした"
      redirect_to action: "new"
    end
  end

  def edit
    @card = Card.find(params[:user_id])
  end

  def update
    @item.update(item_params)
    if @item.save
      redirect_to item_path
    else
      render :edit
    end
  end
end
