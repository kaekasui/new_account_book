# frozen_string_literal: true
class Place < ActiveRecord::Base
  belongs_to :user
  has_many :categorize_places, dependent: :destroy
  has_many :categories, through: :categorize_places
  has_many :records

  validates :name,
            presence: true,
            length: { maximum: Settings.place.name.maximum_length }

  def categorize?(category_id)
    categories.map(&:id).include?(category_id)
  end
end
