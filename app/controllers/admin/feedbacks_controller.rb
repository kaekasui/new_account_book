class Admin::FeedbacksController < ApplicationController
  before_action :authenticate
  before_action :admin_authenticate

  def index
    @feedbacks = Feedback::Fetcher.all(params: params)
    @total_count = Feedback.count
  end
end
