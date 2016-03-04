class Category::PlacesController < ApplicationController
  before_action :authenticate

  def index
    category = current_user.categories.find(params[:category_id])
    @places = category.places
  end
end
