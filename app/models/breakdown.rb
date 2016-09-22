# frozen_string_literal: true
class Breakdown < ActiveRecord::Base
  counter_culture :category
  belongs_to :category
  has_many :records
  has_many :captures

  validates :name, presence: true,
                   length: { maximum: Settings.breakdown.name.maximum_length }
end
