class MessagesController < ApplicationController
  before_action :authenticate

  def index
    @messages = Message::Fetcher.all(params: params, user: current_user)
  end

  def show
    @message = current_user.messages.find(params[:id])
    @message.to_read unless @message.read?
  end
end
