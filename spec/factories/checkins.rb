FactoryGirl.define do
  factory :checkin do
    merchant_id { rand(100) }
    person_id { rand(100) }
  end
end
