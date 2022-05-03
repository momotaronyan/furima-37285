class ConnectsController < ApplicationController
  def index
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
end
