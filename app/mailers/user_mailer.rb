class UserMailer < ApplicationMailer
  def registration(email, registration_url)
    @registration_url = registration_url
    mail to: email
  end
end
