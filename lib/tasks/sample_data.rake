namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_postings
    make_relationships
    make_projects
  end
end

def make_users
  admin = User.create!(name:     "Example User",
                       email:    "example@hyve.me",
                       password: "foobar")
  admin.toggle!(:admin)
  99.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password  = "password"
    User.create!(name:     name,
                 email:    email,
                 password: password)
  end
end

def make_postings
  users = User.all(limit: 6)
  50.times do
    content = Faker::Lorem.sentence(5)
    users.each { |user| user.postings.create!(content: content) }
  end
end

def make_relationships
  users = User.all
  user  = users.first
  followed_users = users[2..50]
  followers      = users[3..40]
  followed_users.each { |followed| user.follow!(followed) }
  followers.each      { |follower| follower.follow!(user) }
end

def make_projects
  users = User.all(limit: 15)
  7.times do
    name = Faker::Company.name
    description = Faker::Lorem.sentence(20)
    users.each { |user| user.projects.create!(name: name, description: description) }
  end
end
