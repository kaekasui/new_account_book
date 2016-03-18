class Record::Fetcher
  def initialize(user: nil, params: nil)
    @user = user
    @params = params
  end

  def self.all(user: nil, params: nil)
    new(user: user, params: params).all
  end

  def all
    records = @user.records.order(created_at: :desc)
                   .limit(Settings.records.per)
    records.offset!(@params[:offset]) if @params[:offset].present?
    if @params[:date].present?
      records = records.where(published_at: @params[:date].to_date)
    end
    records
  end
end
