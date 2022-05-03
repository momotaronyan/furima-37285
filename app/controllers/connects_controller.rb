class ConnectsController < ApplicationController
  before_action :return_to_index, only: [:index]
  def index
    @connect = Connect.all
  end

  def new
    @connect = Connect.new
  end

  def create
    @connect = Connect.new(connect_params)
    if @connect.valid?
      @connect.save
      flash[:notice] = "お問い合わせありがとうございます。"
      return redirect_to root_path
    else
      flash[:alert] = "お問い合わせ内容の送信に失敗しました。"
      render 'index'
    end
  end

  private
  def connect_params
    params.require(:connect).permit(:name, :email, :content, :comment)
  end

  def return_to_index
    unless user_signed_in? && current_user.admin?
      redirect_to root_path
    end
  end

end
