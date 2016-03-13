class MessagesController < ApplicationController
  before_action :authenticate

  def index
    @messages = current_user.messages.limit(5).order(created_at: :desc)
  end

  def show
    @message = current_user.messages.find(params[:id])
  end
end
