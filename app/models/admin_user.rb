class AdminUser < User
  def maximum_values
    {
      category: Settings.user.categories.admin_maximum_length,
      breakdown: Settings.category.breakdowns.admin_maximum_length,
      place: Settings.user.places.admin_maximum_length,
      record: Settings.user.records.admin_maximum_length
    }
  end
end
