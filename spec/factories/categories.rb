FactoryGirl.define do
  factory :category do
    user
    barance_of_payments { true | false }
    sequence(:name) { |i| "カテゴリ名#{i}" }
    sequence(:position) { |i| i - 1 }
  end
end
