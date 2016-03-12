class MessagesController < ApplicationController
  before_action :authenticate

  def index
    @messages = current_user.messages.limit(5).order(created_at: :desc)
  end
end
