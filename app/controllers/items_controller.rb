class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :search]
  before_action :id_get, only: [:show, :edit, :update, :destroy]
  before_action :return_to_index, only: [:edit, :destroy]
  def index
    #@items = Item.includes(:user).order("created_at DESC")
    @items = Item.order("created_at DESC").first(8)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:notice] = "アイテムが出品されました✨"
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @comments = @item.comments.includes(:user)
    @comment = Comment.new
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

  def search
    if params[:q]&.dig(:name)
      squished_keywords = params[:q][:name].squish
      params[:q][:name_cont_any] = squished_keywords.split(" ")
    end
    @q = Item.ransack(params[:q])
    @items = @q.result.page(params[:page]).per(30).order("created_at DESC")
  end
  private

  def item_params
    if current_user.admin?
      params.require(:item).permit({images: []}, :name, :information, :category_id, :status_id, :burden_id, :prefecture_id, :scheduled_delivery_id, :price).merge(user_id: @item.user.id)
    else
      params.require(:item).permit({images: []}, :name, :information, :category_id, :status_id, :burden_id, :prefecture_id, :scheduled_delivery_id, :price).merge(user_id: current_user.id)
    end
  end

  def id_get
    @item = Item.find(params[:id])
  end

  def return_to_index
    unless current_user.admin?
      unless current_user.id == @item.user_id
        redirect_to action: :index
      end
    end
    if @item.order
      redirect_to action: :index
    end
  end
end
