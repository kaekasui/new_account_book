class CategoriesController < ApplicationController
  before_action :authenticate

  def index
    @categories = current_user.categories.order(:position)
  end

  def create
    @category = current_user.categories.new(new_category_params)
    if @category.save
      head 201
    else
      render_error @category
    end
  end

  def update
    @category = current_user.categories.find(params[:id])
    if @category.update(name: params[:name])
      head 200
    else
      render_error @category
    end
  end

  def destroy
    @category = current_user.categories.find(params[:id])
    if @category.destroy
      head 200
    else
      render_error @category
    end
  end

  def sort
    @list = Category::List.new(current_user, params[:sequence])
    if @list.sort
      head 200
    else
      render_error @list
    end
  end

  private

  def new_category_params
    params.permit(:name, :barance_of_payments)
  end
end
