# frozen_string_literal: true
class Record::Fetcher
  attr_accessor :total_count

  def initialize(user: nil, params: nil, sort_type: nil)
    @user = user
    @params = params
    @sort_type = sort_type
  end

  def all
    records = @user.records.order_type(@sort_type)
    records = records.the_day(@params[:date]) if @params[:date].present?
    if @params[:year].present? || @params[:month].present?
      records = records.the_year_and_month(@params[:year], @params[:month])
    end
    @total_count = records.count
    records = records.offset(@params[:offset]) if @params[:offset].present?
    records = records.limit(Settings.records.per)
    records
  end
end
