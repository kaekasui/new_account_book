# frozen_string_literal: true
FactoryGirl.define do
  factory :capture do
    user
    published_at Time.zone.today
    charge { rand(0..10_000) }
    sequence(:category_name) { |i| "カテゴリ#{i}" }
    sequence(:breakdown_name) { |i| "内訳#{i}" }
    sequence(:place_name) { |i| "場所#{i}" }
    sequence(:memo) { |i| "めも#{i}" }
    sequence(:tags) { |i| "タグ#{i}" }
  end
end
