class EmailUser::RegistrationsController < ApplicationController
  def create
    @user = EmailUser.new(sign_up_params)
    @user.status = :inactive
    if @user.save
      origin = "#{request.protocol}#{request.host_with_port}"
      UserMailer.registration(@user.email, @user.registration_url(origin))
        .deliver_now
      head 201
    else
      render_error @user
    end
  end

  private

  def sign_up_params
    params.permit(:email, :password, :password_confirmation)
  end
end
