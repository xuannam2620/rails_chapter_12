User.create!(name: "Admin", email: "admin@framgia.com",
  password: "foobar", password_confirmation: "foobar", admin: true)
User.create!(name: "Tran Xuan Nam", email: "tran.xuan.nam@framgia.com",
  password: "foobar", password_confirmation: "foobar", admin: false)
99.times do |n|
  name = Faker::Name.name
  email = "example#{n}@framgia.com"
  password = "foobar"
  User.create!(name: name, email: email, password: password,
    password_confirmation: password)
end
