class Category < ActiveRecord::Base
  belongs_to :user

  validates :name,
            presence: true,
            length: { maximum: Settings.category.name.maximum_length }

  before_create :set_position

  def set_position
    self.position = user.categories.count
  end
end
