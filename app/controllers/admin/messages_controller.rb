class Admin::MessagesController < ApplicationController
  before_action :authenticate
  before_action :admin_authenticate

  def index
    @messages = Message::Fetcher.all(params: params)
    @total_count = Message.count
  end
end
