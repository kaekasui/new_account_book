class TopController < ApplicationController
  def index
    @notices = Notice::Fetcher.all(params: params).published
  end
end
