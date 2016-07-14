FactoryGirl.define do
  sequence :email do |n|
    "bperson#{n}@example.com"
  end
end

FactoryGirl.define do
  factory :user do
    name     "Taras Bilous"
    email    
    password "foobar"
    password_confirmation "foobar"
  end
end