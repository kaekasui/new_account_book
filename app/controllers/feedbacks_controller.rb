# frozen_string_literal: true
class FeedbacksController < ApplicationController
  def create
    @feedback = Feedback.new(feedback_params)
    if @feedback.save
      @feedback.notice_to_slack if Rails.env.production?
      AdminMailer.notice_feedback(@feedback).deliver_later
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
