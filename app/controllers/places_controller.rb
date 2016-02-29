class PlacesController < ApplicationController
  before_action :authenticate

  def index
    @places = current_user.places
  end
end
