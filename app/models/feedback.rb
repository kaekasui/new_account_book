class Feedback < ActiveRecord::Base
  belongs_to :user
  validates :content, presence: true
  validates :email, presence: true, unless: 'email.nil?'
end
