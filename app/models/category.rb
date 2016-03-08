class Category < ActiveRecord::Base
  belongs_to :user
  has_many :breakdowns
  has_many :categorize_places, dependent: :destroy
  has_many :places, through: :categorize_places

  validates :name,
            presence: true,
            length: { maximum: Settings.category.name.maximum_length }

  before_create :set_position
  before_destroy :confirm_contents

  def set_position
    self.position = user.categories.count
  end

  def confirm_contents
    if breakdowns.any?
      errors[:base] << I18n.t('errors.messages.categories.destroy_breakdowns')
      false
    end
  end

  def selected_place?(place_id)
    places.map(&:id).include?(place_id)
  end
end
