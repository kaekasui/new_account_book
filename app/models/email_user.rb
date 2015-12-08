class EmailUser < User
  has_secure_password

  validates :email, presence: true,
                    length: { maximum: Settings.user.email.maximum_length }
  validate :uniqueness_email, if: 'email.present?'

  private

  def uniqueness_email
    errors.add(:email, :uniqueness_email) if User.where(email: email).present?
  end
end
