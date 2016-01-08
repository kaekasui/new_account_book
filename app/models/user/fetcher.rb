class User::Fetcher
  def initialize(params:)
    @params = params
  end

  def self.all(params:)
    new(params: params).all
  end

  def all
    users = User.order(id: :desc)
    if @params[:offset].present?
      users.offset!(@params[:offset]).limit(Settings.users.per)
    end
    users
  end
end
