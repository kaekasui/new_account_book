class Category::List
  include ActiveModel::Model

  def initialize(user, sequence)
    @user = user
    @sequence = sequence
  end

  def sort
    @user.categories.each do |item|
      item.update!(position: @sequence.index(item.id))
    end
    true
  rescue
    errors[:base] << I18n.t('errors.messages.categories.failed_to_sort')
    false
  end
end
