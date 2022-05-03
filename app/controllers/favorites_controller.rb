class FavoritesController < ApplicationController
  before_action :item_get
  def create
    @favorite = Favorite.new(user_id: current_user.id,  item_id: @item.id)
    @favorite.save
  end

  def destroy
    @favorite = Favorite.find_by(user_id: current_user.id, item_id:  @item.id)
    @favorite.destroy
  end

  private
  def item_get
    @item = Item.find(params[:item_id])
  end
end
