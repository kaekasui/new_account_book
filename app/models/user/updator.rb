class User::Updator
  include ActiveModel::Model

  attr_accessor :new_email
  validates :new_email, email_format: { allow_blank: true },
                        length: { maximum: Settings.user.email.maximum_length }

  def initialize(user: nil, params: nil)
    @user = user
    @new_email = params[:new_email]
    @nickname = params[:nickname]
  end

  def save
    return false if invalid?
    return save_nickname if @nickname
    return save_new_email if @new_email
  end

  private

  def save_nickname
    if @user.update(nickname: @nickname)
      true
    else
      errors[:base] << @user.errors.full_messages.join(',')
      false
    end
  end

  def save_new_email
    if @new_email.blank? && @user.update(email: @new_email)
      true
    elsif @user.update(new_email: @new_email)
      # TODO: メール送信
      true
    else
      errors[:base] << @user.errors.full_messages.join(',')
      false
    end
  end
end
