class Place::CategoriesController < ApplicationController
  before_action :authenticate

  def update
    @place = current_user.places.find(params[:place_id])
    category = current_user.categories.find(params[:id])
    @place.categories << category
    head 201
  rescue ActiveRecord::RecordInvalid => ex
    render_error ex.record
  end
end
