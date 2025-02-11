# メインのサンプルユーザーを1人作成する
main_user = User.create!(
  user_name: "rikkyo",
  email: "rikkyo@gmail.com",
  password: "rikkyo",
  password_confirmation: "rikkyo",
  admin: true
)
main_user.skip_confirmation!  # 確認メールをスキップ
main_user.save!

# メインユーザーのサンプルポストを作成
20.times do
  main_user.posts.create!(
    title: Faker::Book.title,  # タイトルを追加
    content: Faker::Lorem.paragraph(sentence_count: 3),
    created_at: rand(1..30).days.ago
  )
end



# 追加のユーザーをまとめて生成する
30.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railsstudy.org"
  password = "password"
  user = User.create!(
    user_name: name,
    email: email,
    password: password,
    password_confirmation: password
  )
  user.skip_confirmation!  # 確認メールをスキップ
  user.save!
  
  # 各ユーザーに5-15個のランダムな投稿を作成
  rand(5..15).times do
    user.posts.create!(
      title: Faker::Book.title,  # タイトルを追加
      content: Faker::Lorem.paragraph(sentence_count: 2),
      created_at: rand(1..30).days.ago
    )
  end
end

puts "サンプルデータの作成が完了しました！"
puts "作成されたユーザー数: #{User.count}"
puts "作成された投稿数: #{Post.count}"