class User::Fetcher
  def initialize(params:)
    @params = params
  end

  def self.all(params:)
    new(params: params).all
  end

  def all
    users = User.order(id: :desc).limit(Settings.users.per)
    users.offset!(@params[:offset]) if @params[:offset].present?
    users
  end
end
