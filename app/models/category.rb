class Category < ActiveRecord::Base
  has_many :breakdowns
  belongs_to :user

  validates :name,
            presence: true,
            length: { maximum: Settings.category.name.maximum_length }

  before_create :set_position
  before_destroy :confirm_breakdowns

  def set_position
    self.position = user.categories.count
  end

  def confirm_breakdowns
    if breakdowns.any?
      errors[:base] << I18n.t('errors.messages.categories.failed_destroy')
      return false
    end
  end
end
