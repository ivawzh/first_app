namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: "Example User",
                 email: "example@railstutorial.org",
                 password: "foobar",
                 password_confirmation: "foobar")
    User.create!(name: "Ivan (admin)",
                 email: "raywzh@hotmail.com",
                 password: "foobar",
                 password_confirmation: "foobar",
                admin: true,)

    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end

    users = User.all(limit: 6)
    User.find_by(email: "raywzh@hotmail.com").each do |user|
      50.times do
        user.microposts.create!(content: Faker::Lorem.sentence(5))
      end
    end
    users.each do |user|
      50.times do
      user.microposts.create!(content: Faker::Lorem.sentence(5))
      end
    end
  end
end