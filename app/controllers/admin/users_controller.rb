class Admin::UsersController < ApplicationController
  before_action :authenticate
  before_action :admin_authenticate

  def index
    @users = User::Fetcher.all(params: params)
  end
end
