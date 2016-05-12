class DashboardsController < ApplicationController
  before_action :authenticate

  def show
    updator = Tally::Updator.new(user: current_user, year: params[:year], month: params[:month])
    updator.save
    @tally = updator.tally
  end
end
