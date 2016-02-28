class NoticesController < ApplicationController
  before_action :authenticate

  def index
    @notices = Notice::Fetcher.all(params: params).published
  end

  def show
    @notice = Notice.find(params[:id])
  end
end
