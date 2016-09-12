FactoryGirl.define do
  sequence :email do |n|
    "privat#{n}@example.com"
  end
  name = 'Taras Bilous'
  password = 'foobar'


  factory :user do
    name name
    email
    password password
    password_confirmation password
  end

 # Admin
  factory :admin, class: User do
    name name
    email
    password password
    password_confirmation password
    admin true
  end
end

FactoryGirl.define do
  bdate = Time.new(1973, 10, 15)
  factory :character, class: Character do
    name 'Character Patient'
    comment 'Patient'
    birthday bdate
    sex true
    usd true
    user
  end
end

FactoryGirl.define do
  name = 'Taras Bilous'
  comment = 'Lorem ipsum dolor sit amet'
  email = 'contact@email.com'
  factory :contact  do
    name    name
    comment comment
    phone '1231231212'
    email   email
    address 'Chernivrsi, Nezalezhnosti str'
    latitude (48.268707)
    longitude (25.927730)
  end
end

FactoryGirl.define do
  date = DateTime.now.to_date
  comment = 'Lorem ipsum dolor sit amet'
  factory :adata, class: Anthropometry do
    date    date
    comment comment
    height  90
    weight  12.5
    cranium 60
    chest   50
  end
end
