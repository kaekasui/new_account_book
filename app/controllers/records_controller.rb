class RecordsController < ApplicationController
  before_action :authenticate

  def index
    @records = Record::Fetcher.all(user: current_user, params: params)
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

  private

  def record_params
    params.permit(:published_at, :charge,
                  :category_id, :breakdown_id, :place_id)
  end
end