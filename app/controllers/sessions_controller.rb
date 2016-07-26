# frozen_string_literal: true
require 'socket'

class SessionsController < ApplicationController
  def create
    @session = Session.new(login_params)
    render_error @session, 401 unless @session.save
    @user = @session.user
    @session
  end

  def callback
    auth_user = User.find_or_create(request.env['omniauth.auth'])
    origin = "#{request.protocol}#{host_with_port}"
    if auth_user
      @token = auth_user.find_token_by_name(:access) ||
               auth_user.add_access_token
      auth_user.update!(status: :registered, last_sign_in_at: Time.zone.now)
      redirect_to "#{origin}/#/?token=#{@token.token}"
    else
      render :error401, status: 401
    end
  end

  private

  def login_params
    params.permit(:email, :password)
  end

  def host_with_port
    request.host == 'localhost' ? 'localhost:3000' : request.host_with_port
  end
end
