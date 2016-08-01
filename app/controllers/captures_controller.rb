# frozen_string_literal: true
class CapturesController < ApplicationController
  before_action :authenticate

  def index
  end

  def import
    head 201
  end
end
