# frozen_string_literal: true
FactoryGirl.define do
  factory :auth do
    provider ''
    sequence(:screen_name) { |n| "名前#{n}" }
    sequence(:name) { |n| "name#{n}" }
  end
end
