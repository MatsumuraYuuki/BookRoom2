# メインユーザーの作成と投稿（既存のコード）
main_user = User.create!(
  user_name: "rikkyo",
  email: "rikkyo@gmail.com",
  password: "rikkyo",
  password_confirmation: "rikkyo",
  admin: true
)
main_user.skip_confirmation!
main_user.save!

# メインユーザーの投稿作成（既存のコード）
20.times do
  main_user.posts.create!(
    title: Faker::Book.title,
    content: Faker::Lorem.paragraph(sentence_count: 3),
    created_at: rand(1..30).days.ago
  )
end

# 追加のユーザー作成（既存のコード）
users = []
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
  user.skip_confirmation!
  user.save!
  users << user  # 後でフォロー関係を作成するために配列に保存
  
  # 投稿作成（既存のコード）
  rand(5..15).times do
    user.posts.create!(
      title: Faker::Book.title,
      content: Faker::Lorem.paragraph(sentence_count: 2),
      created_at: rand(1..30).days.ago
    )
  end
end

# フォロー関係の作成
users.each do |user|
  # 各ユーザーが5-20人のランダムなユーザーをフォロー
  following = users.sample(rand(5..20))
  following.each do |other_user|
    user.follow(other_user) unless user == other_user
  end
end

# メインユーザー(rikkyo)のフォロー関係を作成
following_users = users.sample(15)  # 15人をランダムにフォロー
following_users.each { |user| main_user.follow(user) }

# メインユーザーのフォロワーを作成
followers = users.sample(10)  # 10人のユーザーがメインユーザーをフォロー
followers.each { |user| user.follow(main_user) }

puts "サンプルデータの作成が完了しました！"
puts "作成されたユーザー数: #{User.count}"
puts "作成された投稿数: #{Post.count}"
puts "作成されたフォロー関係の数: #{Relationship.count}"
puts "メインユーザー(rikkyo)のフォロー数: #{main_user.following.count}"
puts "メインユーザー(rikkyo)のフォロワー数: #{main_user.followers.count}"