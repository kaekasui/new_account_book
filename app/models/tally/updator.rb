class Tally::Updator
  include ActiveModel::Model

  attr_accessor :tally

  def initialize(user: nil, params: { year: 2016, month: 5 })
    # TODO: デフォルト値を修正する
    @user = user
    @params = params
  end

  def save
    @tally = Tally.find_or_initialize_by(
      user_id: @user.id, year: @params[:year], month: @params[:month])
    if @tally.updated_at.blank? || (@tally.updated_at.present? &&
      @tally.updated_at > Settings.tally.interval.seconds.from_now)
      @tally.update_list
    end
    true
  end
end
