User.create! name: "admin",
  email: "admin@gmail.com",
  password: "foobar",
  password_confirmation: "foobar",
  is_admin: true

User.create! name: "Lylogi",
  email: "ly@example.com",
  password: "111111",
  password_confirmation: "111111",
  is_admin: true 

User.create! name: "Example User", email: "example@railstutorial.org",
  password: "123456", password_confirmation: "123456", is_admin: true

49.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "123456"
  User.create! name: name, email: email, password: password,
    password_confirmation: password
end

users = User.all
user = users.first
following = users[2..50]
followers = users[3..40]
following.each {|followed| user.follow(followed)}
followers.each {|follower| follower.follow(user)}

Category.create! name: "Rails"
Category.create! name: "Ruby"
