class UserMailer < ApplicationMailer
  # アカウント登録のご案内
  def registration(email, registration_url)
    @registration_url = registration_url
    mail to: email
  end

  # アカウント登録完了のお知らせ
  def finished_registration(email)
    @email = email
    mail to: email
  end

  # パスワードリセットのご案内
  def password_reset(email, password_reset_url)
    @email = email
    @password_reset_url = password_reset_url
    mail to: email
  end

  # アカウントのご確認
  def confirmation(email)
    @email = email
    mail to: email
  end
end
