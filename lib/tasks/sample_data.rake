namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(name: "Example Admin",
                         email: "admin@hyve.me",
                         password: "foobar")
    admin.toggle!(:admin)

    User.create!(name: "Example User",
                 email: "example@hyve.me",
                 password: "foobar")
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@hyve.me"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password)
    end

    users = User.all(limit: 6)
    50.times do
      content = Faker::Lorem.sentence(5)
      users.each { |user| user.postings.create!(content: content) }
    end
  end
end
