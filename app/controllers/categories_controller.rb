class CategoriesController < ApplicationController
  before_action :authenticate

  def index
    @categories = current_user.categories.order(:position)
  end

  def sort
    @list = Category::List.new(current_user, params[:sequence])
    if @list.sort
      head 200
    else
      render_error @list
    end
  end
end
