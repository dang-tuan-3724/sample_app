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