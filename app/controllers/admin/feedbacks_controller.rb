class Admin::FeedbacksController < ApplicationController
  before_action :authenticate
  before_action :admin_authenticate

  def index
    @feedbacks = Feedback::Fetcher.all(params: params)
    @total_count = Feedback.count
  end

  def check
    @feedback = Feedback.find(params[:feedback_id])
    render_error @feedback unless @feedback.update(checked: !@feedback.checked)
  end
end
