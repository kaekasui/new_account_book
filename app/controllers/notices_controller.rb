class NoticesController < ApplicationController
  before_action :authenticate, only: %i(index)

  def index
    @notices = Notice::Fetcher.all(params: params).published
  end

  def show
    @notice = Notice.find(params[:id])
  end
end
