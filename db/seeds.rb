require 'faker'

# Create Users
5.times do 
  user = User.new(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: Faker::Lorem.characters(10)
    )
  user.skip_confirmation!
  user.save!
end

users = User.all

#Create Wikis
50.times do
  Wiki.create(
    title: Faker::Lorem.sentence,
    body: Faker::Lorem.paragraph,
    user: users.sample,
    private: false
    )
end

user = User.new(
  email: "ryumaster001@yahoo.com",
  password: "helloworld",
  name: "Gerald Oliva",
  role: 'premium'
  )
user.skip_confirmation!
user.save!

user = User.new(
  email: "member@example.com",
  password: "helloworld",
  name: "Member Smith"
  )
user.skip_confirmation!
user.save!

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"