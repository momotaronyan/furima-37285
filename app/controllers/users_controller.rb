class UsersController < ApplicationController

  def show
    time = Time.now
    @year = time.year
    @month = time.month
    @user = User.find(params[:id])
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"] # 環境変数を読み込む
    card = Card.find_by(user_id: @user.id) # ユーザーのid情報を元に、カード情報を取得
    #redirect_to new_card_path and return unless card.present?
    if card.present?
      customer = Payjp::Customer.retrieve(card.customer_token) # 先程のカード情報を元に、顧客情報を取得
      @card = customer.cards.first
    end
  end

  def update
    if current_user.update(user_params) # 更新出来たかを条件分岐する
      redirect_to root_path # 更新できたらrootパスへ
    else
      redirect_to action: "show" # 失敗すれば再度マイページへ
    end
  end

  def favorites
    @user = User.find(params[:id])
    favorites= Favorite.where(user_id: @user.id).pluck(:item_id)
    @favorite_items = Item.find(favorites)
  end
  private

  def user_params
    params.require(:user).permit(:name, :email) # 編集出来る情報を制限
  end

end