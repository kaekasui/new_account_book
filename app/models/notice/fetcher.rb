class Notice::Fetcher
  def initialize(params: nil)
    @params = params
  end

  def self.all(params: nil)
    new(params: params).all
  end

  def all
    notices = Notice.order(post_at: :desc).limit(Settings.notices.per)
    notices.offset!(@params[:offset]) if @params[:offset].present?
    notices
  end
end
