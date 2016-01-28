class UsersController < ApplicationController
  before_action :authenticate

  def show
    @user = current_user
  end

  def update
    if current_user.update(user_params)
      head 200
    else
      render_error current_user
    end
  end

  private

  def user_params
    params.permit(:nickname)
  end
end
