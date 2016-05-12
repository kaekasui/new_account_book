class DashboardsController < ApplicationController
  before_action :authenticate

  def show
    updator = Tally::Updator.new(user: current_user, params: params)
    updator.save
    @tally = updator.tally
  end
end
