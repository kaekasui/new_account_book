class BreakdownsController < ApplicationController
  before_action :authenticate

  def index
    @category = current_user.categories.find(params[:category_id])
    @breakdowns = @category.breakdowns
  end
end
