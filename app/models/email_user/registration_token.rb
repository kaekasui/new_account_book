# frozen_string_literal: true
class EmailUser::RegistrationToken
  include ActiveModel::Model

  attr_accessor :user, :email
  validates :email, presence: true
  validate :should_find_user, if: 'email.present? && user.nil?'

  def initialize(user, email = nil)
    @user = user
    @email = email
  end

  def recreate(origin)
    return false if invalid?
    @user.remove_token(:registration)
    UserMailer.registration(@user.email, @user.registration_url(origin))
              .deliver_now
  end

  private

  def should_find_user
    errors[:base] << I18n.t('errors.messages.registrations.not_found_email')
  end
end
