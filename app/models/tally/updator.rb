class Tally::Updator
  include ActiveModel::Model

  attr_accessor :tally

  def initialize(user: nil, params: {})
    @user = user
    @year = params[:year] || Time.zone.today.year
    @month = params[:month] || Time.zone.today.month
  end

  def save
    @tally = Tally.find_or_initialize_by(
      user_id: @user.id, year: @year, month: @month)
    if @tally.updated_at.blank? || (@tally.updated_at.present? &&
      @tally.updated_at > Settings.tally.interval.seconds.from_now)
      @tally.update_list(@year, @month)
    end
    true
  end
end
