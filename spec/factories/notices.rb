FactoryGirl.define do
  factory :notice do
    sequence(:title) { |n| "タイトル#{n}" }
    sequence(:content) { |n| "お知らせ内容#{n}" }
    post_at { Time.zone.now }
  end
end
