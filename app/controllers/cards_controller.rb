class CardsController < ApplicationController
  before_action :authenticate_user!
  before_action :return_to_root, only: [:new, :create]

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


  def destroy
    @card = current_user.card
    if @card.blank?
      redirect_to action: "new"
    else
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      customer = Payjp::Customer.retrieve(@card.customer_token)
      customer.delete
      @card.delete
      flash[:notice] = "クレジットカードの情報を登録し直してください"
      redirect_to action: "new"
    end  
  end

  private
  def return_to_root
    @user = current_user
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    card = Card.find_by(user_id: @user.id)
    if card.present?
      redirect_to root_path
    end
  end
end
