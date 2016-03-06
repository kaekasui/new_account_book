class Category < ActiveRecord::Base
  belongs_to :user
  has_many :breakdowns
  has_many :categorize_places
  has_many :places, through: :categorize_places

  validates :name,
            presence: true,
            length: { maximum: Settings.category.name.maximum_length }

  before_create :set_position
  before_destroy :confirm_breakdowns

  scope :income, -> { where(barance_of_payments: true) }
  scope :outgo, -> { where(barance_of_payments: false) }

  def set_position
    self.position = user.categories.count
  end

  def confirm_breakdowns
    if breakdowns.any?
      errors[:base] << I18n.t('errors.messages.categories.failed_destroy')
      return false
    end
  end

  def selected_place?(place_id)
    places.map(&:id).include?(place_id)
  end
end
