FactoryGirl.define do
  sequence :email do |n|
    "person#{n}@example.com"
  end
end

FactoryGirl.define do
  name = "Taras Bilous"
  password = "foobar"
  factory :user  do
    name     name
    email    
    password password
    password_confirmation password
  end
  factory :admin, class: User do
    admin      true
  end
end


