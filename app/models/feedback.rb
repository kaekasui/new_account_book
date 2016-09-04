# frozen_string_literal: true
class Feedback < ActiveRecord::Base
  belongs_to :user
  has_many :messages

  validates :content,
            presence: true,
            length: { maximum: Settings.feedback.content.maximum_length }
  validates :email,
            presence: true,
            length: { maximum: Settings.feedback.email.maximum_length },
            unless: 'email.nil?'

  def notice_to_slack
    Slack.chat_postMessage(
      text: "```#{content}```",
      username: "#{user.try(:id)}. #{user.try(:_name)}#{email}",
      channel: '#feedbacks'
    )
  end
end
