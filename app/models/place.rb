class Place < ActiveRecord::Base
  belongs_to :user
  has_many :categorize_places
  has_many :categories, through: :categorize_places
end
