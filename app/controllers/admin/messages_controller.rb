class Admin::MessagesController < ApplicationController
  before_action :authenticate
  before_action :admin_authenticate

  def create
    @message = Message.new(message_params)
    if @message.save
      head 201
    else
      render_error @message
    end
  end

  private

  def message_params
    params.permit(:content, :feedback_id, :user_id)
  end
end
