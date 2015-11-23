FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "email#{n}@example.com" }
    trait :twitter do
      type 'TwitterUser'
    end
  end
end
