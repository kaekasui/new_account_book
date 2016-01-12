class EmailUser::Password
  include ActiveModel::Model

  # attr_accessor :current_password
  # validates :current_password,
  #           presence: true,
  #           length: { maximum: Settings.user.password.maximum_length }
  # TODO: プロフィール変更時、current_passwordが存在する場合に設定する

  def initialize(user, params)
    @user = user
    @params = params
    self.current_password = @params[:current_password]
  end

  def update
    return false if invalid?
    if @user.update(password: @params[:password],
                    password_confirmation: @params[:password_confirmation])
      true
    else
      errors[:base] << @user.errors.full_messages.join(',')
      false
    end
  end

  def authenticate
    return false if invalid?
    @user.authenticate(@params[:current_password])
  end
end
