class Category::List
  def initialize(user, sequence)
    @user = user
    @sequence = sequence
  end

  def sort
    @user.categories.each do |item|
      position = @sequence.index(item.id.to_s)
      item.update!(position: position)
    end
    true
  rescue
    errors[:base] << I18n.t('errors.messages.categories.failed_to_sort')
    false
  end
end
