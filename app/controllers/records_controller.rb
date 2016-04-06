class RecordsController < ApplicationController
  before_action :authenticate

  def index
    fetcher = Record::Fetcher.new(user: current_user, params: params)
    @records = fetcher.all
    @total_count = fetcher.total_count
  end

  def show
    @record = current_user.records.find(params[:id])
  end

  def new
    @user = current_user
    @categories = current_user.categories
                              .order(:position)
    # TODO: N+1を解消する
  end

  def create
    @record = current_user.records.new(record_params)
    if @record.save
      head 201
    else
      render_error @record
    end
  end

  def edit
    @user = current_user
    @categories = current_user.categories
                              .order(:position)
    @record = current_user.records.find(params[:id])
  end

  def update
    @record = current_user.records.find(params[:id])
    if @record.update(record_params)
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
end
