class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show] # ログイン要求
  before_action :authenticate_admin!, only: [:destroy] # 管理者要求
  before_action :set_user, only: [:show, :destroy] # @userの設定

  def show
  end

  def index
    @users = User.page(params[:page]).per(10)
  end

  def destroy
    if @user.destroy
      redirect_to users_path, notice: 'ユーザーを削除しました'
    else
      redirect_to @user, alert: '削除に失敗しました'
    end
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
    if @user.nil?
      flash[:alert] = 'ユーザーが見つかりません'
      redirect_to users_path
    end
  end

  def authenticate_admin!
    unless current_user&.admin?
      flash[:alert] = "管理者権限が必要です"
      redirect_to root_path
    end
  end

  def user_params
    params.require(:user).permit(:user_name, :email, :admin)
  end
end