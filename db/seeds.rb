# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar")

50.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end
20.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  comment = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In est nulla, tristique vitae augue eu, pulvinar viverra fusce."
  geo = "25.625565"
  address = "Chernivrsi, Nezalezhnosti str"
  Contact.create!(name:  name,
               email: email,
               comment: comment,
               address: address,
               phone: '1231231212'
               latitude: 48.268707,
               longitude: 25.927730,
               photo: "")
end