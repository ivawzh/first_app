namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_microposts
    make_relationships
  end

  def make_users
    User.create!(name: "Example User",
                 email: "example@railstutorial.org",
                 password: "foobar",
                 password_confirmation: "foobar")
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
    User.create!(name: "Ivan (admin)",
                 email: "raywzh@hotmail.com",
                 password: "foobar",
                 password_confirmation: "foobar",
                 admin: true,)
  end


  def make_microposts
    ivan = User.find_by(email: "raywzh@hotmail.com")
    50.times do
      ivan.microposts.create!(content: Faker::Lorem.sentence(5))
    end


    users = User.all(limit: 6)
    users.each do |user|
      50.times do
        user.microposts.create!(content: Faker::Lorem.sentence(5))
      end
    end
  end



  def make_relationships
    users = User.all
    ivan = users.find_by(email: "raywzh@hotmail.com")
    followed_users = users[0..48]
    followed_users.each do |followed_user|
      ivan.follow!(followed_user)
    end
    followers = users[3..40]
    followers.each { |follower| follower.follow!(ivan) }
  end
end