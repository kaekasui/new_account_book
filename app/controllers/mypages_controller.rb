class MypagesController < ApplicationController
  before_action :authenticate

  def show
    @notices = Notice::Fetcher.all(params: params).published
    @messages = Message::Fetcher.all(params: params, user: current_user)
    fetcher = Record::Fetcher
              .new(user: current_user, params: params, sort_type: 'lately')
    @records = fetcher.all
  end
end
