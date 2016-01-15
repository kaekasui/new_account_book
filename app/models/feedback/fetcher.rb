class Feedback::Fetcher
  def initialize(params:)
    @params = params
  end

  def self.all(params:)
    new(params: params).all
  end

  def all
    feedbacks = Feedback.order(id: :desc).limit(Settings.feedbacks.per)
    feedbacks.offset!(@params[:offset]) if @params[:offset].present?
    feedbacks
  end
end
