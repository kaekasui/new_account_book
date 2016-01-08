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

  def regist
    @user = EmailUser.find(params[:registration_id].to_i)
    if @user.registered_by(params[:token])
      UserMailer.finished_registration(@user.email).deliver_now
      host = Rails.env.production? ? '' : 'http://localhost:3000'
      redirect_to "#{host}/#/?registed=ok"
    else
      render_error @user, 401
    end
  end

  def recreate
    @user = EmailUser.inactive.find_by(email: params[:email])
    fail ActiveRecord::RecordNotFound if params[:email].present? && @user.nil?
    @registration = EmailUser::RegistrationToken.new(@user, params[:email])
    origin = "#{request.protocol}#{request.host_with_port}"
    if @registration.recreate(origin)
      head 200
    else
      render_error @registration
    end
  end

  private

  def sign_up_params
    params.permit(:email, :password, :password_confirmation)
  end
end
