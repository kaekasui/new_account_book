# frozen_string_literal: true
class Record::Fetcher
  attr_accessor :total_count

  def initialize(user: nil, params: nil, sort_type: nil)
    @user = user
    @sort_type = sort_type
    @year = params[:year]
    @month = params[:month]
    @date = params[:date]
    @offset = params[:offset]
  end

  def all
    records = @user.records.order_type(@sort_type)
    records = records.the_day(@date) if @date.present?
    if @year.present? || @month.present?
      records = records.the_year_and_month(@year, @month)
    end
    @total_count = records.count
    records = records.offset(@offset) if @offset.present?
    records = records.limit(Settings.records.per)
    records
  end
end
