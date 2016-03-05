class CategorizePlace < ActiveRecord::Base
  belongs_to :category
  belongs_to :place

  validates :category_id, uniqueness: { scope: :place_id }
  # validates :place, uniqueness: { scope: :category_id }
end
