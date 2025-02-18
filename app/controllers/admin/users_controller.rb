class Admin::UsersController < Admin::BaseController
  # 管理者ようのユーザーコントローラー
  before_action :set_user, only: [:destroy]

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
    return unless @user.nil?

    flash[:alert] = 'ユーザーが見つかりません'
    redirect_to users_path
  end
end
