class User < ActiveRecord::Base
  tokenizable
  has_many :feedbacks
  has_many :categories
  has_many :places
  has_many :messages
  has_many :records

  enum status: { registered: 2, inactive: 1 }

  validates :categories,
            length: { maximum: Settings.user.categories.maximum_length,
                      too_long: I18n.t('errors.messages.too_long') },
            unless: :admin
  validates :places,
            length: { maximum: Settings.user.places.maximum_length,
                      too_long: I18n.t('errors.messages.too_long') },
            unless: :admin

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
    when 'FacebookUser' then 'label-primary'
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
    if type == 'EmailUser'
      nickname || email
    else
      nickname || auth.try(:name) || auth.try(:screen_name)
    end
  end

  def self.find_or_create(auth)
    klass = (auth['provider'].capitalize + 'User').constantize
    Auth.find_by_uid(auth['uid']).try(auth['provider'] + '_user') ||
      klass.create_with(auth)
  end
end
