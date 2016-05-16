class User < ActiveRecord::Base
  tokenizable
  has_many :feedbacks
  has_many :categories
  has_many :places
  has_many :messages
  has_many :records
  has_many :tags
  has_many :tallies

  enum status: { inactive: 1, registered: 2 }

  validates :nickname,
            length: { maximum: Settings.user.nickname.maximum_length }
  # TODO: ユーザーのランクによって制限数を変更する
  validates :categories,
            length: { maximum: Settings.user.categories.maximum_length,
                      too_long: I18n.t('errors.messages.too_many') },
            unless: :admin
  validates :places,
            length: { maximum: Settings.user.places.maximum_length,
                      too_long: I18n.t('errors.messages.too_many') },
            unless: :admin

  before_create :set_currency

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

  def new_email_url(origin)
    token = new_email_token.token
    "#{origin}/user/authorize_email?user_id=#{id}&token=#{token}"
  end

  def new_email_token
    @new_email_token ||= add_new_email_token
  end

  def update_email_by(token)
    token_user = User.find_by_valid_token(:new_email, token)
    if self == token_user
      update(email: new_email, new_email: '') && remove_token(:new_email)
    else
      errors[:base] << I18n.t('errors.messages.users.invalid_token')
      false
    end
  end

  def each_maximum_values
    if admin?
      user = self.becomes(AdminUser)
      user.maximum_values
    else
      maximum_values
    end
  end

  private

  def maximum_values
    {
      category: Settings.user.categories.maximum_length,
      breakdown: Settings.category.breakdowns.maximum_length,
      place: Settings.user.places.maximum_length,
      record: Settings.user.records.maximum_length
    }
  end

  def add_new_email_token
    add_token(
      :new_email,
      size: Settings.password_token.length,
      expires_at: Settings.new_email_token.expire_after.seconds.from_now
    )
  end

  def set_currency
    self.currency = '¥'
    # TODO: ロケールによりデフォルトを変更する
  end
end
