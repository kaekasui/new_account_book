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

  def send_mail(origin)
    @user.remove_token(:new_email)
    UserMailer.set_new_email(@user.new_email, @user.new_email_url(origin))
              .deliver_now
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
    if (@new_email.blank? && @user.update(email: @new_email)) ||
       @user.update(new_email: @new_email)
      true
    else
      errors[:base] << @user.errors.full_messages.join(',')
      false
    end
  end
end
