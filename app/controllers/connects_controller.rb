class ConnectsController < ApplicationController
  def index
    @connect = Connect.new
  end

  def create
    @connect = Connect.new(connect_params)
    if @connect.valid?
      @connect.save
      return redirect_to user_path(current_user)
    else
      render 'index'
    end
  end

  private
  def connect_params
    params.require(:connect).permit(:name, :email, :content, :comment)
  end
end
