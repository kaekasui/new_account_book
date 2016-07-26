# frozen_string_literal: true
class User::Fetcher
  def initialize(params: nil)
    @params = params
  end

  def self.all(params: nil)
    new(params: params).all
  end

  def all
    users = User.order(id: :desc).limit(Settings.users.per)
    users.offset!(@params[:offset]) if @params[:offset].present?
    users
  end
end
