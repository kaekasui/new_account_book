class Record < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  belongs_to :breakdown
  belongs_to :place

  validates :published_at, presence: true
  validates :charge, presence: true,
                     numericality: { only_integer: true,
                                     greater_than_or_equal_to: 0,
                                     less_than_or_equal_to: 9_999_999,
                                     allow_blank: true }
  validates :category, presence: true

  scope :the_day, -> (target_day) { where(published_at: target_day.to_date) }
  scope :the_year_and_month, lambda { |year, month|
    start_day = 10.years.ago
    end_day = 10.years.since
    if year.present? && month.present?
      start_day = Date.new(year.to_i, month.to_i, 1)
      end_day = start_day.end_of_month
    elsif year.present? && month.blank?
      start_day = Date.new(year.to_i, 1, 1)
      end_day = start_day.end_of_year
    elsif year.blank? && month.present?
      start_day = Date.new(Time.zone.today.year, month.to_i, 1)
      end_day = start_day.end_of_month
    end
    where(published_at: start_day..end_day)
  }
  scope :order_type, lambda { |sort_type|
    if sort_type == 'lately'
      order(created_at: :desc)
    else
      order(published_at: :desc, created_at: :desc)
    end
  }
end
