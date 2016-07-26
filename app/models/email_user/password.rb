# frozen_string_literal: true
class EmailUser::Password
  include ActiveModel::Model

  attr_accessor :user, :current_password
  validates :user,
            presence: { message: I18n.t('errors.messages.users.invalid_url') }

  def initialize(user, params)
    @user = user
    @params = params
  end

  def update
    return false if invalid?
    if @user.update(password: @params[:password],
                    password_confirmation: @params[:password_confirmation]) &&
       @user.remove_token(:password)
      true
    else
      errors[:base] << @user.errors.full_messages.join(',')
      false
    end
  end
end
