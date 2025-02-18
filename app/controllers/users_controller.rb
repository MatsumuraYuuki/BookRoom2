class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show] # ログイン要求
  before_action :authenticate_admin!, only: [:destroy] # 管理者要求
  before_action :set_user, only: [:show, :destroy] # @userの設定

  def index
    @users = User.page(params[:page]).per(10)
  end

  def show
    @users = User.page(params[:page]).per(10)
    @posts = @user.posts.order(created_at: :desc).page(params[:page]).per(10)
  end

  def destroy
    if @user.destroy
      redirect_to users_path, notice: 'ユーザーを削除しました'
    else
      redirect_to @user, alert: '削除に失敗しました'
    end
  end

  def following
    @title = 'フォロー中'
    @user = User.find(params[:id])
    @users = @user.following.page(params[:page])
    render 'show_follow'
  end

  def followers
    @title = 'フォロワー'
    @user = User.find(params[:id])
    @users = @user.followers.page(params[:page])
    render 'show_follow'
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
    return unless @user.nil?

    flash[:alert] = 'ユーザーが見つかりません'
    redirect_to users_path
  end

  def authenticate_admin!
    return if current_user&.admin?

    flash[:alert] = '管理者権限が必要です'
    redirect_to root_path
  end

  def user_params
    params.require(:user).permit(:user_name, :email, :admin)
  end
end
