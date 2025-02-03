class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show] # ログイン必須

  #/users/13232・/users/indexなどの存在しないIDにアクセスしようとした際に、Railsがindexをidパラメータとして解釈しようとして発生しまうエラーが存在している
  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
  end
end
