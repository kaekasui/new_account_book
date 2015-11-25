class User < ActiveRecord::Base
  tokenizable
  has_secure_password

  def active?
    true
  end

  def add_access_token
    add_token(
      :access,
      size: Settings.access_token.length,
      expires_at: Settings.access_token.expire_after.seconds.from_now
    )
  end
end
