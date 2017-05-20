FactoryGirl.define do
  factory :user do
    name Faker::Name.name
    email Faker::Internet.email
    image_url Faker::Internet.url
  end
end
