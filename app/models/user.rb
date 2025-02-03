class User < ApplicationRecord
  has_many :posts # 追加

  
  devise :database_authenticatable, #DBに保存されたpassが正しいかどうかの検証
         :registerable, #基本的にUser登録、編集、削除機能を作成することができる
         :recoverable, #パスワードをリセットする 
         :rememberable, #20日間ログインしたままにすると言った、永続ログイン機能を作成
         :validatable #emailのフォーマットやpassの長さなど、一般的なバリデーションを追加

  validates :user_name, presence: true, length: { maximum: 20 } # 変更
end