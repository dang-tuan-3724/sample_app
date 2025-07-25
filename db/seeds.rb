User.delete_all
User.create!(
  name: 'Dang Tuan',
  email: 'admin@example.com',
  password: '456456',
  password_confirmation: '456456',
  admin: true,
  activated: true,
  activated_at: Time.zone.now
)
99.times do |n|
  User.create!(
    name: Faker::Name.name,
    email: "user#{n + 1}@example.com",
    password: "password",
    password_confirmation: "password",
    activated: true,
    activated_at: Time.zone.now
  )
end

users = User.order(:created_at).take(6)
10.times do
  content = Faker::Quote.famous_last_words
  users.each { |user| user.microposts.create!(content: content) }
end

# following relationships
users = User.all
user = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
