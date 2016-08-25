# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = User.create(name: 'Example User',
                   email: 'ex@railstutorial.org',
                   password: 'foobar',
                   password_confirmation: 'foobar')
user.save!
50.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = 'password'
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password)
end
admin = User.create!(name: 'Taras Bilous',
                     email: 'tbilous@yahoo.com',
                     password: 'foobar',
                     password_confirmation: 'foobar',
                     admin: true)
admin.save
20.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  comment = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
  address = 'Chernivrsi, Nezalezhnosti str'
  Contact.create!(name: name,
                  email: email,
                  comment: comment,
                  address: address,
                  phone: '1231231212',
                  latitude: 48.268707,
                  longitude: 25.927730,
                  user_id: admin.id)
end
2.times do |n|
  b_date = Time.new((1973 + n+1), 10, 15)
  name = Faker::Name.name
  comment = 'Lorem ipsum dolor sit amet'
  Character.create!(name: name,
                    comment: comment,
                    birthday: b_date,
                    sex: true,
                    usd: true,
                    user_id: admin.id
  )
end