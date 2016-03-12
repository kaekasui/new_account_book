class Message::Fetcher
  def initialize(params: nil)
    @params = params
  end

  def self.all(params: nil)
    new(params: params).all
  end

  def all
    messages = Message.order(created_at: :desc).limit(Settings.messages.per)
    messages.offset!(@params[:offset]) if @params[:offset].present?
    messages
  end
end
