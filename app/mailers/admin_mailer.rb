class AdminMailer < ApplicationMailer
  # フィードバックのお知らせ
  def notice_feedback(feedback)
    @feedback = feedback
    mail to: Settings.mail_from
  end
end
