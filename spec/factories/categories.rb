# frozen_string_literal: true
FactoryGirl.define do
  factory :category do
    user
    barance_of_payments { true | false }
    trait :income do
      barance_of_payments true
    end
    trait :outgo do
      barance_of_payments false
    end
    sequence(:name) { |i| "カテゴリ名#{i}" }
    sequence(:position) { |i| i - 1 }
  end
end
