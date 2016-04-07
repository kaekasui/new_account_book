FactoryGirl.define do
  factory :tag do
    user
    sequence(:name) { |i| "ラベル#{i}" }
    color_code { format('%06x', (rand * 0xffffff)) }
  end
end
