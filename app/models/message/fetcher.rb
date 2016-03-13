class Message::Fetcher
  def initialize(params: nil, user: nil)
    @params = params
    @user = user
  end

  def self.all(params: nil, user: nil)
    new(params: params, user: user).all
  end

  def all
    messages = (@user ? @user.messages : Message.all)
    messages = messages.includes(:user, :feedback)
                       .order(created_at: :desc)
                       .limit(Settings.messages.per)
    messages.offset!(@params[:offset]) if @params[:offset].present?
    messages
  end
end
