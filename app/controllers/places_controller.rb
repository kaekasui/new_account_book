class PlacesController < ApplicationController
  before_action :authenticate

  def index
    @places = current_user.places
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
