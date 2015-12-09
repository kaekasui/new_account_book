class EmailUser < User
  has_secure_password

  validates :email, presence: true,
                    length: { maximum: Settings.user.email.maximum_length }
  validate :uniqueness_email, if: 'email.present?'

  def registration_url(origin)
    token = registration_token.token
    "#{origin}/email_user/registrations/#{id}?token=#{token}"
  end

  def registration_token
    add_registration_token
  end

  private

  def uniqueness_email
    if EmailUser.where(email: email).where.not(id: id).present?
      errors.add(:email, :uniqueness)
    else
      true
    end
  end
end
