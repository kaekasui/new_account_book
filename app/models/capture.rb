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
  validates :tags,
            length: { maximum: Settings.capture.tags.maximum_length }
  validates :memo,
            length: { maximum: Settings.record.memo.maximum_length }

  def build_comments
    valid?
    self.category_existence = category.present?
    if category_name.present? && category.nil?
      errors.add(:category_name, :unregistered)
    end
    self.breakdown_existence = breakdown.present?
    if breakdown_name.present? && breakdown.nil?
      errors.add(:breakdown_name, :unregistered)
    end
    self.comment = errors.full_messages.join(',')
  end

  def category
    user.categories.find_by(name: category_name)
  end

  def breakdown
    category.breakdowns.find_by(name: breakdown_name) if category
  end
end
