class PlacesController < ApplicationController
  before_action :authenticate

  def index
    @places = current_user.places.order(created_at: :desc)
  end

  def create
    @place = current_user.places.new(place_params)
    if @place.save
      head 201
    else
      render_error @place
    end
  end

  def destroy
    @place = current_user.places.find(params[:id])
    if @place.destroy
      head 200
    else
      render_error @place
    end
  end

  private

  def place_params
    params.permit(:name)
  end
end
