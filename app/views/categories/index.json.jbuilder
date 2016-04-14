json.categories do
  json.array! @categories do |category|
    json.id category.id
    json.name category.name
    json.barance_of_payments category.barance_of_payments
    json.breakdowns_count category.breakdowns_count
    json.places_count category.places_count
    json.records_count category.records_count
  end
end
