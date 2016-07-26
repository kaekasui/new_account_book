# frozen_string_literal: true
class Feedback::Fetcher
  def initialize(params: nil)
    @params = params
  end

  def self.all(params: nil)
    new(params: params).all
  end

  def all
    feedbacks = Feedback.order(id: :desc)
                        .includes(:user)
                        .limit(Settings.feedbacks.per)
    feedbacks.offset!(@params[:offset]) if @params[:offset].present?
    feedbacks
  end
end
