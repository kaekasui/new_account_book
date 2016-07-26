# frozen_string_literal: true
FactoryGirl.define do
  factory :place do
    user
    sequence(:name) { |i| "場所名#{i}" }
  end
end
