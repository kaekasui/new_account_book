class SessionsController < ApplicationController
  def create
    @session = Session.new(login_params)
    render_error @session, 401 unless @session.save
    @session
  end

  def callback
    auth_user = User.find_or_create(request.env['omniauth.auth'])
    if auth_user
      @token = auth_user.find_token_by_name(:access) ||
               auth_user.add_access_token
      auth_user.update!(status: :registered, last_sign_in_at: Time.zone.now)
      redirect_to 'http://localhost:3000/#/?token=' + @token.token
    else
      render :error401, status: 401
    end
  end

  private

  def login_params
    params.permit(:email, :password)
  end
end
