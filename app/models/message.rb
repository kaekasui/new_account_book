# frozen_string_literal: true
class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :feedback

  validates :content,
            presence: true,
            length: { maximum: Settings.message.content.maximum_length }
  validates :user, presence: true

  def to_read
    update(read: true)
  end
end
