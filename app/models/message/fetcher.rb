# frozen_string_literal: true
class Message::Fetcher
  def initialize(params: {}, user: nil)
    @params = params
    @user = user
  end

  def self.all(params: {}, user: nil)
    new(params: params, user: user).all
  end

  def all
    messages = (@user ? @user.messages : Message.all)
    messages = messages.order(created_at: :desc)
                       .limit(Settings.messages.per)
    messages.offset!(@params[:offset]) if @params[:offset].present?
    messages
  end
end
