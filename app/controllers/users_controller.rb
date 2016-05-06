class UsersController < ApplicationController
  before_action :authenticate, except: %i(authorize_email)

  def show
    @user = current_user
  end

  def settings
    @user = current_user
    @currencies = Settings.currencies
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

  # PATCH /user/setting
  def setting
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

  # POST /user/send_mail
  def send_mail
    user_updator = User::Updator
                   .new(user: current_user,
                        params: { new_email: current_user.new_email })
    origin = "#{request.protocol}#{request.host_with_port}"
    if user_updator.send_mail(origin)
      head 200
    else
      render_error user_updator
    end
  end

  private

  def user_params
    params.permit(:new_email, :nickname)
  end

  def setting_params
    params.permit(:breakdown_field, :place_field, :tag_field, :memo_field,
                  :currency)
  end
end
