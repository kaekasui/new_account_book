# frozen_string_literal: true
class CapturesController < ApplicationController
  before_action :authenticate

  def index
    @user = current_user
    @captures = @user.captures.order(created_at: :desc)
  end

  def show
    @capture = current_user.captures.find(params[:id])
    @capture.build_comments
    @capture.save(validate: false)
  end

  def update
    @capture = current_user.captures.find(params[:id])
    @capture.assign_attributes(capture_params)
    @capture.build_comments
    if @capture.save
      head 200
    else
      render_error @capture
    end
  end

  def destroy
    capture = current_user.captures.find(params[:id])
    capture.destroy
    head capture.destroyed? ? :ok : :forbidden
  end

  def import
    updator = Capture::Updator.new(user: current_user, lines: params['data'])
    if updator.import
      head 201
    else
      render_error updator
    end
  end

  private

  def capture_params
    params.permit(:published_at, :category_name, :breakdown_name, :place_name,
                  :charge, :memo, :tags)
  end
end
