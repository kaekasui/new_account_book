class Category::PlacesController < ApplicationController
  before_action :authenticate
  before_action :set_category

  def index
    @places = @category.places
    @user_places = current_user.places.includes(:categories).order(created_at: :desc)
  end

  def create
    @place = current_user.places.find_or_initialize_by(place_params)
    if current_user.save
      @place.categories << @category
    else
      render_error current_user
    end
  rescue ActiveRecord::RecordInvalid => ex
    render_error ex.record
  end

  private

  def set_category
    @category = current_user.categories.find(params[:category_id])
  end

  def place_params
    params.permit(:name)
  end
end
