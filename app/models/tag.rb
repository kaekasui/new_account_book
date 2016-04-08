class Tag < ActiveRecord::Base
  belongs_to :user

  has_many :tagged_records
  has_many :records, through: :tagged_records

  validates :name,
            presence: true,
            uniqueness: true,
            length: { maximum: Settings.tag.name.maximum_length }

  before_save :set_color_code

  def set_color_code
    hex_color = format('%06x', (rand * 0xfffff))
    self.color_code = '#' + hex_color if color_code.blank?
  end
end
