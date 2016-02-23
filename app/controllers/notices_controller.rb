class NoticesController < ApplicationController
  before_action :authenticate

  def index
    @notices = Notice::Fetcher.all(params: params).published
  end
end
