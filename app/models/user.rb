class User < ActiveRecord::Base
  tokenizable

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
end
