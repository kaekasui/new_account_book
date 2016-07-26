# frozen_string_literal: true
class TopController < ApplicationController
  def index
    @notices = Notice::Fetcher.all.published
  end
end
