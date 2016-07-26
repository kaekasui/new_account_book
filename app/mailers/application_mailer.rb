# frozen_string_literal: true
class ApplicationMailer < ActionMailer::Base
  default from: Settings.mail_from
end
