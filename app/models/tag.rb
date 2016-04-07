class Tag < ActiveRecord::Base
  belongs_to :user

  has_many :tagged_records
  has_many :records, through: :tagged_records
end
