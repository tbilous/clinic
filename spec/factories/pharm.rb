FactoryGirl.define do
  factory :pharm_type, class: PharmType do
    name 'Pharm Type'
    comment 'Pharm Type example'
    slug '12345'

    # user_id
    user
  end
end

FactoryGirl.define do
  factory :pharm_owner, class: PharmOwner do
    name 'Pharm Owner'
    comment 'Pharm Owner example'

    # user_id
    user
  end
end

FactoryGirl.define do
  factory :pharm, class: Pharm do
    name 'Pharm medicines'
    comment 'Pharm example'
    attention 'Attention'
    dose '0.5'
    volume '2'
    pharm_type
    pharm_owner

    # user_id
    user
  end
end
