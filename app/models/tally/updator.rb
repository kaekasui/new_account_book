# frozen_string_literal: true
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
      user_id: @user.id, year: @year.to_i, month: @month.to_i
    )
    if @tally.updated_at.blank? || (@tally.updated_at.present? &&
      @tally.updated_at < Settings.tally.interval.seconds.until)
      @tally.update_list(@year.to_i, @month.to_i)
    end
    true
  end
end
