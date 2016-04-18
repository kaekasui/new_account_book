json.category do
  json.name @category.name
  json.barance_of_payments @category.barance_of_payments
end

json.places do
  json.array! @places do |place|
    json.id place.id
    json.name place.name
  end
end
