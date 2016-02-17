class User < ActiveRecord::Base
  tokenizable
  has_one :auth
  has_many :feedbacks
  has_many :categories

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

  def status_label_name
    case status
    when 'inactive' then 'label-default'
    when 'registered' then 'label-success'
    end
  end

  def type_label_name
    case type
    when 'EmailUser' then 'label-warning'
    when 'TwitterUser' then 'label-info'
    end
  end

  def _status
    I18n.t("labels.status.#{status}")
  end

  def _type
    I18n.t("labels.type.#{type.underscore}")
  end

  def last_login_time
    I18n.l(last_sign_in_at) if last_sign_in_at
  end

  def _name
    name || nickname || email
  end

  def self.create_with_omniauth(_auth)
  end
end
