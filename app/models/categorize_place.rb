class CategorizePlace < ActiveRecord::Base
  belongs_to :category
  belongs_to :place
end
