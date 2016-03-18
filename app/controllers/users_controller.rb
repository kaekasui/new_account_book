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

  def set_display
    if current_user.update(setting_params)
      head 200
    else
      render_error current_user
    end
  end

  private

  def user_params
    params.permit(:nickname)
  end

  def setting_params
    params.permit(:breakdown_field, :place_field, :memo_field)
  end
end
