class TagsController < ApplicationController
  before_action :authenticate

  def index
    @tags = current_user.tags
  end
end
