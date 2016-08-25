# frozen_string_literal: true
class CapturesController < ApplicationController
  before_action :authenticate

  def index
    @user = current_user
    @captures = @user.captures
  end

  def import
    updator = Capture::Updator.new(user: current_user, lines: params['data'])
    if updator.import
      head 201
    else
      render_error updator
    end
  end
end
