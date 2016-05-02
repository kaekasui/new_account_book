class UsersController < ApplicationController
  before_action :authenticate, except: %i(authorize_email)

  def show
    @user = current_user
  end

  def settings
    @user = current_user
  end

  def update
    user_updator = User::Updator.new(user: current_user, params: user_params)
    if user_updator.save
      if user_updator.new_email.present?
        origin = "#{request.protocol}#{request.host_with_port}"
        user_updator.send_mail(origin)
      end
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

  # GET /user/authorize_email
  def authorize_email
    user = User.find(params[:user_id])
    if user.update_email_by(params[:token])
      host = Rails.env.production? ? '' : 'http://localhost:3000'
      redirect_to "#{host}/#/?updated_email=ok"
    else
      render_error user, 401
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
