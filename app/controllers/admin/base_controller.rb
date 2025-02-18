class Admin::BaseController < ApplicationController
  # 管理者向けのユーザー管理
  before_action :authenticate_admin!

  private

  def authenticate_admin!
    return if current_user&.admin?

    flash[:alert] = '管理者権限が必要です'
    redirect_to root_path
  end
end
