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
end
