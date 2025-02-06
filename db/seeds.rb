# メインのサンプルユーザーを1人作成する
User.create!(user_name:  "rikkyo",
             email: "rikkyo@gmail.com",
             password:              "rikkyo",
             password_confirmation: "rikkyo")

# 追加のユーザーをまとめて生成する
99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railsstudy.org"
  password = "password"
  User.create!(user_name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end
