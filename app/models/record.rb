class Record < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  belongs_to :breakdown
  belongs_to :place

  validates :charge, presence: true
end
