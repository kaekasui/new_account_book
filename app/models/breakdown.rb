class Breakdown < ActiveRecord::Base
  belongs_to :category
  has_many :records

  validates :name, presence: true
end
