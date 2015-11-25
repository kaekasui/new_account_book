class SessionsController < ApplicationController
  def create
    @session = Session.new(login_params)
    render_error @session, 401 unless @session.save
    @session
  end

  private

  def login_params
    params.permit(:email, :password)
  end
end
