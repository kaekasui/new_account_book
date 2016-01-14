FactoryGirl.define do
  factory :feedback do
    trait :login_user do
      user
      email nil
    end
    email { Faker::Internet.email }
    checked false
    sequence(:content) { |i| "問い合わせ内容１\n問い合わせ内容２#{i}" }
  end
end
