json.places do
  json.array! @places do |place|
    json.id place.id
    json.name place.name
    json.categories do
      json.array! place.categories do |category|
        json.id category.id
        json.name category.name
        json.barance_of_payments category.barance_of_payments
      end
    end
  end
end
