class EmailUser::PasswordsController < ApplicationController
  def send_mail
    origin = "#{request.protocol}#{request.host_with_port}"
    email = params[:email]
    @user = EmailUser.find_by(email: email)
    if @user
      UserMailer.password_reset(email, @user.password_reset_url(origin))
        .deliver_later
    else
      UserMailer.confirmation(email).deliver_later
    end
    head 200
  end

  def edit
  end

  def update
  end
end
