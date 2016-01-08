class Admin::UsersController < ApplicationController
  before_action :authenticate
  before_action :admin_authenticate

  def index
    @users = User.all
  end
end
