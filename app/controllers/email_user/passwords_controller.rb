class EmailUser::PasswordsController < ApplicationController
  before_action :set_user, only: %i(edit update)

  def send_mail
    origin = "#{request.protocol}#{request.host_with_port}"
    email = params[:email]
    return render_error EmailUser.new, 422 if email.blank?
    @user = EmailUser.find_by(email: email)
    if @user
      @user.send_to_reset_password(origin)
    else
      UserMailer.confirmation_account(email, origin).deliver_later
    end
    head 200
  end

  def edit
    fail ActiveRecord::RecordNotFound if @user != @token_user
    host = Rails.env.production? ? '' : 'http://localhost:3000'
    form_params = {
      user_id: params[:id],
      email: @user.email,
      token: params[:token]
    }
    redirect_to "#{host}/#/edit_password?#{URI.encode_www_form(form_params)}"
  end

  def update
    fail ActiveRecord::RecordNotFound if @user != @token_user
    password_form = EmailUser::Password.new(@user, password_reset_params)
    return render_error password_form if password_form.invalid?
    return render_error password_form unless password_form.update
    head 200
  end

  private

  def set_user
    @user = EmailUser.find(params[:id])
    @token_user = User.find_by_valid_token(:password, params[:token])
  end

  def password_reset_params
    params.permit(:current_password, :password, :password_confirmation)
  end
end
