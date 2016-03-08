class Place::CategoriesController < ApplicationController
  before_action :authenticate
  before_action :set_place, only: [:index, :update, :destroy]

  def index
    @categories = current_user.categories.order(:position)
  end

  def update
    category = current_user.categories.find(params[:id])
    @place.categories << category
    head 201
  rescue ActiveRecord::RecordInvalid => ex
    render_error ex.record
  end

  def destroy
    categorize = @place.categorize_places.find_by!(category_id: params[:id])
    categorize.destroy
    head categorize.destroyed? ? :ok : :forbidden
  end

  private

  def set_place
    @place = current_user.places.find(params[:place_id])
  end
end
