# frozen_string_literal: true
class CategoriesController < ApplicationController
  before_action :authenticate

  def index
    @user = current_user
    @categories = @user.categories.order(:position)
  end

  def create
    current_user.categories.new(new_category_params)
    if current_user.save
      head 201
    else
      render_error current_user
    end
  end

  def update
    @category = current_user.categories.find(params[:id])
    if @category.update(name: params[:name],
                        barance_of_payments: params[:barance_of_payments])
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
