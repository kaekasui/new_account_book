class Admin::NoticesController < ApplicationController
  before_action :authenticate
  before_action :admin_authenticate

  def index
    @notices = Notice::Fetcher.all(params: params)
    @total_count = Notice.count
  end
end
