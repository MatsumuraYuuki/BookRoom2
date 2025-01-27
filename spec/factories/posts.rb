FactoryBot.define do
  # create(:post) という1行だけで Post を作成できるようにする
  factory :post do
    #デフォルト値。値が指定されていればそちらに上書きされる
    title { 'タイトル1' }
    content { '本文1' }

    #Post に紐づく User も作成できるように設定している
    association :user, factory: :user
  end
end