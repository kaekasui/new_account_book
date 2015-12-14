class EmailUser::RegistrationToken
  include ActiveModel::Model

  attr_accessor :email
  validates :email, presence: true

  def initialize(user, email)
    @user = user
    self.email = email
  end

  def recreate(origin)
    return false if invalid?
    @user.remove_token(:registration)
    UserMailer.registration(@user.email, @user.registration_url(origin))
      .deliver_now
  end
end
