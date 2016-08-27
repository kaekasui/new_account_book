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
    errors.add(:category_name, :unregistered) if unregistered_category?
    self.breakdown_existence = breakdown.present?
    errors.add(:breakdown_name, :unregistered) if unregistered_breakdown?
    self.comment = errors.full_messages.join(',')
  end

  def category
    user.categories.find_by(name: category_name)
  end

  def unregistered_category?
    category_name.present? && category.nil?
  end

  def breakdown
    category.breakdowns.find_by(name: breakdown_name) if category
  end

  def unregistered_breakdown?
    breakdown_name.present? && breakdown.nil?
  end

  def place
    category.places.find_by(name: place_name) if category
  end

  def unregistered_place?
    place_name.present? && place.nil?
  end
end
