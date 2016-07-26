class PlacesController < ApplicationController
  before_action :authenticate
  before_action :set_place, only: [:update, :destroy]

  def index
    @user = current_user
    # TODO: N+1を解消する
    @places = @user.places.order(created_at: :desc)
  end

  def create
    current_user.places.new(place_params)
    if current_user.save
      head 201
    else
      render_error current_user
    end
  end

  def update
    if @place.update(name: params[:name])
      head 200
    else
      render_error @place
    end
  end

  def destroy
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

  def set_place
    @place = current_user.places.find(params[:id])
  end
end
