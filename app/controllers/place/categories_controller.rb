class Place::CategoriesController < ApplicationController
  before_action :authenticate
  before_action :set_place, only: [:index, :update]

  def index
    @income_categories = current_user.categories.income.order(:position)
    @outgo_categories = current_user.categories.outgo.order(:position)
  end

  def update
    category = current_user.categories.find(params[:id])
    @place.categories << category
    head 201
  rescue ActiveRecord::RecordInvalid => ex
    render_error ex.record
  end

  private

  def set_place
    @place = current_user.places.find(params[:place_id])
  end
end
