class MypagesController < ApplicationController
  before_action :authenticate

  def show
    @notices = Notice::Fetcher.all(params: params).published
    @messages = Message::Fetcher.all(params: params, user: current_user)
  end
end
