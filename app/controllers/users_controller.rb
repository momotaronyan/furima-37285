class UsersController < ApplicationController

  def show
    time = Time.now
    @year = time.year
    @month = time.month
    @user = User.find(params[:id])
    @item = @user.items.page(params[:page]).per(15).order("created_at DESC")
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"] # 環境変数を読み込む
    card = Card.find_by(user_id: @user.id) # ユーザーのid情報を元に、カード情報を取得
    #redirect_to new_card_path and return unless card.present?
    if card.present?
      customer = Payjp::Customer.retrieve(card.customer_token) # 先程のカード情報を元に、顧客情報を取得
      @card = customer.cards.first
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params) 
      bypass_sign_in(@user) 
      redirect_to user_path(@user)
    else
      redirect_to edit_user_path
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def favorites
    @user = User.find(params[:id])
    favorites= Favorite.where(user_id: @user.id).pluck(:item_id)
    @favorite_items = Item.find(favorites)
  end


  private

  def user_params
    params.require(:user).permit(:nickname, :email, :password, :password_confirmation, :family_name, :first_name, :family_name_kana, :first_name_kana, :birthday) # 編集出来る情報を制限
  end

end