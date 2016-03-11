class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :feedback

  validates :name,
            presence: true,
            length: { maximum: Settings.place.name.maximum_length }
end
