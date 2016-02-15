class Admin::NoticesController < ApplicationController
  before_action :authenticate
  before_action :admin_authenticate

  def index
    @notices = Notice::Fetcher.all(params: params)
    @total_count = Notice.count
  end

  def create
    @notice = Notice.new(notice_params)
    if @notice.save
      head 201
    else
      render_error @notice
    end
  end

  private

  def notice_params
    params.permit(:post_at, :title, :content)
  end
end
