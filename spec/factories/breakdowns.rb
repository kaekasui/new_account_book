# frozen_string_literal: true
FactoryGirl.define do
  factory :breakdown do
    category
    sequence(:name) { |i| "内訳#{i}" }
  end
end
