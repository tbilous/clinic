namespace :db do
  desc 'Fill database with sample data'
  task populate: :environment do
    User.create!(name: 'Taras Bilous',
                 email: 'tbilous@gmail.com',
                 password: 'foobar',
                 password_confirmation: 'foobar',
                 admin: true)

    99.times do |n|
      name = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password = 'foobar'
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
  end
  task admin: :environment do
    User.create!(name: 'Taras Bilous',
                         email: 'tbilous@yahoo.com',
                         password: 'foobar',
                         password_confirmation: 'foobar',
                         admin: true)
  end

end