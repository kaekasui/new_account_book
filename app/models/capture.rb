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
    messages = errors.full_messages
    self.category_existence = category.present?
    messages << 'カテゴリ名が未登録です' if category_name.present? && category.nil?
    self.breakdown_existence = breakdown.present?
    messages << '内訳が未登録です' if breakdown_name.present? && breakdown.nil?
    self.comment = messages.join(',')
  end

  def category
    user.categories.find_by(name: category_name)
  end

  def breakdown
    category.breakdowns.find_by(name: breakdown_name) if category
  end
end
