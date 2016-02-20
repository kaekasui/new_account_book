class Breakdown < ActiveRecord::Base
  belongs_to :category

  validates :name, presence: true
end
