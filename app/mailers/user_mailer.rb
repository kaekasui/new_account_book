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
end
