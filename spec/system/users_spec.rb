require 'rails_helper'

describe 'User', type: :system do
  before { driven_by :selenium_chrome_headless }

  # ユーザー情報入力用の変数
  let(:email) { 'test@example.com' }
  let(:user_name) { 'テスト太郎' }
  let(:password) { 'password' }
  let(:password_confirmation) { password }

  describe 'ユーザー登録機能の検証' do
    before { visit '/users/sign_up' }

    # ユーザー登録を行う一連の操作を subject にまとめる
    # spec/system/users_spec.rb
    subject do
      fill_in 'user_user_name', with: user_name
      fill_in 'user_email', with: email
      fill_in 'user_password', with: password
      fill_in 'user_password_confirmation', with: password_confirmation
      click_button 'ユーザー登録'
    end

    context '正常系' do
      it 'ユーザーを作成できる' do
        expect { subject }.to change(User, :count).by(1) # Userが1つ増える
        expect(current_path).to eq('/') # ユーザー登録後はトップページにリダイレクト
      end
    end
  end
end