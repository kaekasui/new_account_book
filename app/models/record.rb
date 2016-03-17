class Record < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  belongs_to :breakdown
  belongs_to :place

  validates :published_at, presence: true
  validates :charge, presence: true,
                     numericality: { only_integer: true,
                                     greater_than_or_equal_to: 0,
                                     allow_blank: true }
  validates :category, presence: true
end
