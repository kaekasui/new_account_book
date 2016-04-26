class UsersController < ApplicationController
  before_action :authenticate

  def show
    @user = current_user
  end

  def settings
    @user = current_user
  end

  def update
    user_updator = User::Updator.new(user: current_user, params: user_params)
    if user_updator.save
      head 200
    else
      render_error user_updator
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
    params.permit(:new_email, :nickname)
  end

  def setting_params
    params.permit(:breakdown_field, :place_field, :tag_field, :memo_field)
  end
end
