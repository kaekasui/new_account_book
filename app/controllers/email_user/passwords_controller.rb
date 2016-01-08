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
      UserMailer.confirmation(email).deliver_later
    end
    head 200
  end

  def edit
    fail ActiveRecord::RecordNotFound if @user != @token_user
    head 302 # TODO: 修正する
  end

  def update
    fail ActiveRecord::RecordNotFound if @user != @token_user
    password_form = EmailUser::Password.new(@user, password_reset_params)
    return render_error password_form if password_form.invalid?
    return render_error password_form, 401 unless password_form.authenticate
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
