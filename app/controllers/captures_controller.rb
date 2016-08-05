# frozen_string_literal: true
class CapturesController < ApplicationController
  before_action :authenticate

  def index
  end

  def import
    updator = Capture::Updator.new(user: current_user, lines: params['data'])
    updator.import
    head 201
  end
end
