class Category < ActiveRecord::Base
  belongs_to :user
  has_many :breakdowns
  has_many :categorize_places, dependent: :destroy
  has_many :places, through: :categorize_places
  has_many :records

  validates :name,
            presence: true,
            length: { maximum: Settings.category.name.maximum_length }
  validates :breakdowns,
            length: { maximum: Settings.category.breakdowns.maximum_length,
                      too_long: I18n.t('errors.messages.too_many') }

  before_create :set_position
  before_destroy :confirm_contents

  def set_position
    self.position = user.categories.count
  end

  def confirm_contents
    if breakdowns.any?
      errors[:base] << I18n.t('errors.messages.categories.destroy_breakdowns')
      return false
    end
    if records.any?
      errors[:base] << I18n.t('errors.messages.categories.destroy_records')
      return false
    end
  end

  def selected_place?(place_id)
    places.map(&:id).include?(place_id)
  end

  def _payments_name
    if barance_of_payments
      I18n.t('labels.barance_of_payments.income')
    else
      I18n.t('labels.barance_of_payments.outgo')
    end
  end
end
