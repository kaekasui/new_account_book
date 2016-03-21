class Record::Fetcher
  attr_accessor :total_count

  def initialize(user: nil, params: nil)
    @user = user
    @params = params
  end

  def all
    records = @user.records.order(created_at: :desc)
    if @params[:date].present?
      records = records.where(published_at: @params[:date].to_date)
    end
    @total_count = records.count
    records.offset!(@params[:offset]) if @params[:offset].present?
    records = records.limit(Settings.records.per)
    records
  end
end
