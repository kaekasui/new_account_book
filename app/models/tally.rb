class Tally < ActiveRecord::Base
  belongs_to :user
  serialize :list, JSON

  attr_accessor :plus_count, :minus_count

  def update_list(year, month)
    from = Date.new(year, month, 1)
    to = from.end_of_month

    self.list = Record.joins(:category)
      .where("published_at > ? and published_at < ?", from, to)
      .pluck("date_trunc('day', published_at) as published", :charge, :barance_of_payments)
      .group_by{|i| i[0].to_s.slice(0, 10)}.map{|i| {date: i[0], plus: i[1].map{|n| n[1] if n[2]}.compact.inject(0, :+), minus: 0 }}
    save
  end
end
