class Record::Fetcher
  attr_accessor :total_count

  def initialize(user: nil, params: nil)
    @user = user
    @params = params
  end

  def all
    records = @user.records.order(published_at: :desc, created_at: :desc)
    records = records.the_day(@params[:published_at]) if @params[:published_at].present?
    if @params[:year].present? || @params[:month].present?
      records = records.the_year_and_month(@params[:year], @params[:month])
    end
    @total_count = records.count
    records.offset!(@params[:offset]) if @params[:offset].present?
    records = records.limit(Settings.records.per)
    records
  end
end
