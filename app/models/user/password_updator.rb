# frozen_string_literal: true
class User::PasswordUpdator < User::Updator
  include ActiveModel::Model

  attr_accessor :current_password, :password, :password_confirmation
  validates :current_password, :password, :password_confirmation,
            presence: true,
            length: { minimum: Settings.user.password.minimum_length,
                      maximum: Settings.user.password.maximum_length,
                      allow_blank: true }
  validates :password, confirmation: true

  def initialize(user: nil, params: nil)
    @user = user
    @current_password = params[:current_password]
    @password = params[:password]
    @password_confirmation = params[:password_confirmation]
  end

  def valid_parameter?
    unless @user.type == 'EmailUser'
      errors.add(:password, :invalid_account)
      return false
    end
    valid?
  end

  def authorize
    if @user.authenticate(@current_password)
      @update_params = { password: @password }
    else
      errors.add(:current_password, :invalid)
    end
    errors.blank?
  end
end
