FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "email#{n}@example.com" }
    password { 'password' }
    trait :twitter do
      type 'TwitterUser'
    end
    last_sign_in_at { Time.zone.now }
  end
end
