class CategoriesController < ApplicationController
  before_action :authenticate

  def index
    @categories = current_user.categories.order(id: :desc)
  end
end
