class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :id_get, only: [:show, :edit, :update, :destroy]
  before_action :return_to_index, only: [:edit, :destroy]
  def index
    @items = Item.includes(:user).order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    
  end

  def edit
    
  end

  def update
    @item.update(item_params)
    if @item.save
      redirect_to item_path
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end
  private

  def item_params
    params.require(:item).permit(:image, :name, :information, :category_id, :status_id, :burden_id, :prefecture_id, :scheduled_delivery_id, :price).merge(user_id: current_user.id)
  end

  def id_get
    @item = Item.find(params[:id])
  end

  def return_to_index
    unless current_user.id == @item.user_id
      redirect_to action: :index
    end
  end
end
