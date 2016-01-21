FactoryGirl.define do
  factory :category do
    user
    sequence(:name) { |i| "カテゴリ名#{i}" }
    sequence(:position) { |i| i }
  end
end
