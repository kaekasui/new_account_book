class User < ActiveRecord::Base
  tokenizable
  has_secure_password

  validates :email, presence: true,
                    length: { maximum: Settings.user.email.maximum_length }
  validate :uniqueness_email, if: 'email.present?'

  enum status: { registered: 2, inactive: 1 }

  def active?
    registered? # TODO: 有効期限を確認する
  end

  def add_access_token
    add_token(
      :access,
      size: Settings.access_token.length,
      expires_at: Settings.access_token.expire_after.seconds.from_now
    )
  end

  private

  def uniqueness_email
    errors.add(:email, :uniqueness_email) if User.where(email: email).present?
  end
end
