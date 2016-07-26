# frozen_string_literal: true
class Admin::UsersController < ApplicationController
  before_action :authenticate
  before_action :admin_authenticate

  def index
    @users = User::Fetcher.all(params: params)
    @total_count = User.count
  end

  def show
    @user = User.find(params[:id])
  end
end
