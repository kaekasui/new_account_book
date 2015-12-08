class EmailUser < User
  has_secure_password

  validates :email, presence: true,
                    length: { maximum: Settings.user.email.maximum_length }
  validate :uniqueness_email, if: 'email.present?'

  private

  def uniqueness_email
    if EmailUser.where(email: email).where.not(id: id).present?
      errors.add(:email, :uniqueness)
    else
      true
    end
  end
end
