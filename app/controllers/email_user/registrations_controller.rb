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

  def update
    @user = EmailUser.find(params[:id].to_i)
    if @user.registered_by(params[:token])
      UserMailer.finished_registration(@user.email).deliver_now
      head 200
    else
      render_error @user, 401
    end
  end

  def recreate
    @user = EmailUser.inactive.find_by(email: params[:email])
    fail ActiveRecord::RecordNotFound if @user.nil?
    @user.remove_token(:registration)
    origin = "#{request.protocol}#{request.host_with_port}"
    UserMailer.registration(@user.email, @user.registration_url(origin))
      .deliver_now
    head 200
  end

  private

  def sign_up_params
    params.permit(:email, :password, :password_confirmation)
  end
end
