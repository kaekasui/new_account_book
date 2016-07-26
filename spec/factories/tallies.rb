# frozen_string_literal: true
FactoryGirl.define do
  factory :tally do
    user
    year [*2010..2016].sample
    month [*1..12].sample
  end
end
