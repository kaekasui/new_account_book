FactoryGirl.define do
  factory :record do
    published_at Time.zone.today
    user
    category
    charge { rand(0..10_000) }
    sequence(:memo) { |i| "めも#{i}" }
  end
end
