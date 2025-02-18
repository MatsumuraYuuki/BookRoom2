class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show] # ログイン要求
  before_action :set_user, only: [:show] # @userの設定

  def index
    @users = User.page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
    @feed_posts = @user.feed.page(params[:page]) if current_user == @user
    @posts = @user.posts.page(params[:page])
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

  def user_params
    params.require(:user).permit(:user_name, :email)
  end
end
