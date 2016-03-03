json.categories do
  json.array! @categories do |category|
    json.id category.id
    json.name category.name
    json.barance_of_payments category.barance_of_payments
    json.breakdowns_count category.breakdowns.count
    json.places_count category.places.count
  end
end
