FactoryGirl.define do
  sequence :email do |n|
    "privat#{n}@example.com"
  end
  name = "Taras Bilous"
  password = "foobar"
  # Devise User Class
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
