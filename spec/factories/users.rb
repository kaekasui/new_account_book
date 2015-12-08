FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "email#{n}@example.com" }
    password { 'password' }
    trait :twitter do
      type 'TwitterUser'
    end
    trait :inactive do
      status :inactive
    end
    trait :registered do
      status :registered
    end
    last_sign_in_at { 2.days.ago }
  end
end
