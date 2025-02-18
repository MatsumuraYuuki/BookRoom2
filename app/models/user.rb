class User < ApplicationRecord
  has_many :posts, dependent: :destroy

  devise :database_authenticatable, # DBに保存されたpassが正しいかどうかの検証
         :registerable, # 基本的にUser登録、編集、削除機能を作成することができる
         :recoverable, # パスワードをリセットする
         :rememberable, # 20日間ログインしたままにすると言った、remembeme機能を作成
         :validatable, # emailのフォーマットやpassの長さなど、一般的なバリデーションを追加
         :confirmable  # ユーザーアカウントのメール認証機能を提供

  validates :user_name, presence: true, length: { maximum: 20 } # 変更

  # ユーザーがフォローしている人を取得するメソッド
  has_many :active_relationships, class_name: 'Relationship',
                                  foreign_key: 'follower_id',
                                  dependent: :destroy,
                                  inverse_of: :follower
  has_many :passive_relationships, class_name: 'Relationship',
                                   foreign_key: 'followed_id',
                                   dependent: :destroy,
                                   inverse_of: :followed

  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  # フォローする
  def follow(other_user)
    following << other_user unless self == other_user
  end

  # フォロー解除する
  def unfollow(other_user)
    following.delete(other_user)
  end

  # フォローしているかどうかを確認
  def following?(other_user)
    following.include?(other_user)
  end

  # フィードの実装は後で行う
  def feed
    # フォローしているユーザーのID配列を取得
    following_ids = 'SELECT followed_id FROM relationships WHERE follower_id = :user_id'
    # 自分の投稿 + フォローしているユーザーの投稿を取得
    Post.where("user_id IN (#{following_ids}) OR user_id = :user_id", user_id: id)
        .includes(:user) # N+1問題を回避
        .order(created_at: :desc) # 新しい投稿を上に
  end
end
