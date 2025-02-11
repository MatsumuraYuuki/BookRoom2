class ApplicationController < ActionController::Base
  # もしdeviseのコントローラーの事なら全てのアクションの前にメソッドを読み込む
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # パラメーターを消毒(sanitize)するイメージ
  # ログイン機能について
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:user_name])
    # devise_parameter_sanitizer.permit(:account_update, keys: [:user_name])
  end
end
