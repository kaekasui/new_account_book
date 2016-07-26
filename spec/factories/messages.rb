# frozen_string_literal: true
FactoryGirl.define do
  factory :message do
    user
    trait :with_feedback do
      feedback
    end
    sequence(:content) { |n| "メッセージ内容#{n}" }
    read false
  end
end
