User.create!(name: "Example User",
  email: "liemnguyenx@gmail.com",
  password: "asdasd",
  password_confirmation: "asdasd",
  admin: true)

99.times do |n|
  name  = Faker::Name.name
  email = "liemnguyenx#{n+1}@railstutorial.org"
  password = "asdasd"
  User.create!(name:  name,
    email: email,
    password: password,
    password_confirmation: password)
end
