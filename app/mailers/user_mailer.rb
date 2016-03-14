class UserMailer < ApplicationMailer
  # TODO: Locationが英語の場合、英語のメールが送信されるようにする

  # アカウント登録のご案内
  def registration(email, registration_url)
    @email = email
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

  # アカウントのご確認と登録のご案内
  def confirm_account(email, origin)
    @email = email
    @origin = origin
    mail to: email
  end

  # アカウント登録状況のご確認と登録のご案内
  def confirm_registration(email, origin)
    @email = email
    @origin = origin
    mail to: email
  end

  # 新しいメッセージが届いています
  def confirm_message(email, origin)
    @email = email
    @origin = origin
    mail to: email
  end
end
