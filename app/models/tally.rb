# frozen_string_literal: true
class Tally < ActiveRecord::Base
  belongs_to :user
  serialize :list, JSON

  attr_accessor :plus_count, :minus_count

  def update_list(year, month)
    self.list =
      get_data(year, month)
      .map { |i|
        { date: i[0],
          plus: i[1].map { |n| n[1] if n[2] }.compact.inject(0, :+),
          minus: i[1].map { |n| n[1] unless n[2] }.compact.inject(0, :+) }
      }
    save
  end

  private

  def get_data(year, month)
    from = Date.new(year, month, 1)
    to = from.end_of_month

    records = user.records.joins(:category)
                  .where('published_at > ? and published_at < ?', from, to)
                  .pluck("date_trunc('day', published_at) as published",
                         :charge, :barance_of_payments)
    records.group_by { |i| i[0].to_s.slice(0, 10) }
  end
end
