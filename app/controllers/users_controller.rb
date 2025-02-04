class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show] # ログイン必須

  #レコードが見つからない場合にnilを返す
  def show
    @user = User.find_by(id: params[:id])
    if @user.nil?
      flash[:alert] = 'ユーザーが見つかりません'
      redirect_to users_path
    end
  end

  def index
    @users = User.all
  end
end
