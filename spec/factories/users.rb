FactoryGirl.define do
  factory :user do
    trait :inactive do
      status :inactive
    end
    trait :registered do
      status :registered
    end
    sequence(:nickname) { |n| "ニックネーム#{n}" }
    last_sign_in_at { 2.days.ago }

    factory :email_user, class: EmailUser do
      sequence(:email) { |n| "email#{n}@example.com" }
      password { 'password' }
      type 'EmailUser'
    end

    factory :twitter_user, class: TwitterUser do
      type 'TwitterUser'
      association :auth, provider: 'twitter'
    end

    factory :facebook_user, class: FacebookUser do
      type 'FacebookUser'
      association :auth, provider: 'facebook'
    end

    trait :admin_user do
      admin true
    end
  end
end
