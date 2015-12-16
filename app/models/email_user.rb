class EmailUser < User
  has_secure_password

  validates :email, presence: true,
                    length: { maximum: Settings.user.email.maximum_length }
  validates :password,
            length: { minimum: Settings.user.password.minimum_length }
  validate :uniqueness_email, if: 'email.present?'

  def registration_url(origin)
    token = registration_token.token
    "#{origin}/email_user/registrations/#{id}?token=#{token}"
  end

  def registration_token
    @registration_token ||= add_registration_token
  end

  def registered_by(token)
    token_user = User.find_by_valid_token(:registration, token)
    if self == token_user
      update(status: :registered) && remove_token(:registration)
    else
      errors[:base] << I18n.t('errors.messages.users.invalid_token')
      false
    end
  end

  def password_reset_url(origin)
    token = password_token.token
    "#{origin}/email_user/passwords/#{id}/edit?token=#{token}"
  end

  def password_token
    @password_token ||= add_password_token
  end

  def update_password(current_password, password, password_confirmation)
    if authenticate(current_password)
      update(password: password, password_confirmation: password_confirmation)
    else
      false
    end
  end

  private

  def uniqueness_email
    if EmailUser.where(email: email).where.not(id: id).present?
      errors.add(:email, :uniqueness)
    else
      true
    end
  end

  def add_registration_token
    add_token(
      :registration,
      size: Settings.registration_token.length,
      expires_at: Settings.registration_token.expire_after.seconds.from_now
    )
  end

  def add_password_token
    add_token(
      :password,
      size: Settings.password_token.length,
      expires_at: Settings.password_token.expire_after.seconds.from_now
    )
  end
end
