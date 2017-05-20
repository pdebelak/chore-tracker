FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    image_url { Faker::Internet.url }
  end

  factory :list do |list|
    name { Faker::Commerce.department }
    users { build_list :user, 1 }
  end
end
