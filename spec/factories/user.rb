FactoryGirl.define do
  sequence :email do |n|
    "privat#{n}@example.com"
  end
  
  name = "Taras Bilous"
  password = "foobar"
 
 
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
    name  "Character Patient"
    comment "Patient"
    birthday bdate
    sex true
    usd true
    active true
    user
  end
end
# FactoryGirl.define do
#   name = "Taras Bilous"
#   password = "foobar"
#   factory :user  do
#     name     name
#     email    { FactoryGirl.generate(:email) }
#     password password
#     password_confirmation
#   end
#   factory :admin, class: User do
#     admin      true
#   end
# end
