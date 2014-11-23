FactoryGirl.define do
  factory :person do
    email { Faker::Internet.email }
  end
end
