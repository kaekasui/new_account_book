# frozen_string_literal: true
class RecordsController < ApplicationController
  before_action :authenticate

  def index
    fetcher = Record::Fetcher.new(user: current_user, params: params)
    @user = current_user
    @records = fetcher.all
    @total_count = fetcher.total_count
  end

  def show
    @record = current_user.records.find(params[:id])
  end

  def new
    @user = current_user
    @categories = @user.categories.order(:position)
    @total_count = @user.records.count
    # TODO: N+1を解消する
  end

  def create
    @record = Record::Generator.new(
      user: current_user,
      record_params: record_params,
      tags_params: tags_params
    )
    if @record.save
      head 201
    else
      render_error @record
    end
  end

  def import
    @record = Record::Generator.new(
      user: current_user, capture_id: params[:capture_id]
    )
    @record.build
    render_error @record unless @record.save
  end

  def export
    fetcher = Record::Fetcher.new(user: current_user, params: params)
    @user = current_user
    @records = fetcher.all_as_csv
    render formats: :csv
  end

  def edit
    @user = current_user
    @categories = current_user.categories
                              .order(:position)
    @record = current_user.records.find(params[:id])
  end

  def update
    @record = current_user.records.find(params[:id])
    if @record.update_with_tags(record_params, tags_params)
      head 200
    else
      render_error @record
    end
  end

  def destroy
    record = current_user.records.find(params[:id])
    record.destroy
    head record.destroyed? ? :ok : :forbidden
  end

  private

  def record_params
    params.permit(:published_at, :charge, :memo,
                  :category_id, :breakdown_id, :place_id)
  end

  def tags_params
    params.permit(tags: [:id, :name, :color_code])[:tags]
  end
end
