class Category < ActiveRecord::Base
  belongs_to :user

  validates :name,
            presence: true,
            length: { maximum: Settings.category.name.maximum_length }
end
