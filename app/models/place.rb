class Place < ActiveRecord::Base
  belongs_to :user
  has_many :categorize_places, dependent: :destroy
  has_many :categories, through: :categorize_places

  validates :name,
            presence: true,
            length: { maximum: Settings.place.name.maximum_length }
end
