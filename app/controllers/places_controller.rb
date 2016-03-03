class PlacesController < ApplicationController
  before_action :authenticate

  def index
    @places =
      if params[:category_id]
        category = current_user.categories.find(params[:category_id])
        category.places
      else
        current_user.places
      end
  end

  def create
    @place = current_user.places.new(place_params)
    if @place.save
      head 201
    else
      render_error @place
    end
  end

  private

  def place_params
    params.permit(:name)
  end
end
