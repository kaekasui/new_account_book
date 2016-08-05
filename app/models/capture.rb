# frozen_string_literal: true
class Capture < ApplicationRecord
  belongs_to :user

  validates :published_at, presence: true
  validates :category_name,
            presence: true,
            length: { maximum: Settings.category.name.maximum_length }
  validates :breakdown_name,
            length: { maximum: Settings.breakdown.name.maximum_length }
  validates :place_name,
            length: { maximum: Settings.place.name.maximum_length }
  validates :charge,
            numericality: { only_integer: true,
                            greater_than_or_equal_to: 0,
                            less_than_or_equal_to: 9_999_999,
                            allow_blank: true }
  validates :memo,
            length: { maximum: Settings.record.memo.maximum_length }
end
