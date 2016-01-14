class FeedbacksController < ApplicationController
  def create
    @feedback = Feedback.new(feedback_params)
    if @feedback.save
      head 201
    else
      render_error @feedback
    end
  end

  private

  def feedback_params
    params.permit(:email, :user_id, :content)
  end
end
