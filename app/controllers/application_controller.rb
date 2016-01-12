class ApplicationController < ActionController::Base
  helper_method :current_user

  class BadRequestError < StandardError; end

  rescue_from Exception, with: :error500 unless Rails.env.development?
  rescue_from ActiveRecord::RecordNotFound,
              ActionController::RoutingError,
              with: :error404
  rescue_from BadRequestError, with: :error400

  def error400(e)
    logger.warn [e, *e.backtrace].join("\n")
    @error = e
    render :error400, status: 400, formats: :json
  end

  def error404(_e = nil)
    render :error404, status: 404, formats: :json
  end

  def error500(e)
    logger.error e.inspect
    logger.error [e, *e.backtrace].join("\n")
    render :error500, status: 500, formats: :json
  end

  def default_render(*args)
    options = args.extract_options!
    if args.present?
      render args, options.merge(formats: :json)
    else
      render options.merge(formats: :json)
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def authenticate
    return current_user.update(last_sign_in_at: Time.zone.now) if current_user
    render :error401, status: 401
  end

  def admin_authenticate
    return if current_user.admin?
    render :error401, status: 401
  end

  def current_user
    @current_user ||= authenticate_with_http_token do |token, _options|
      User.find_by_token(:access, token)
    end
  end

  private

  def render_error(resource, status = 422)
    @resource = resource
    render :validation_error, status: status, formats: :json
  end
end
