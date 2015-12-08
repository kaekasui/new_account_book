class User::RegistrationsController < ApplicationController
  def create
    @user = User.new(sign_up_params)
    @user.status = :inactive
    if @user.save
      # TODO: メールを送信する
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
