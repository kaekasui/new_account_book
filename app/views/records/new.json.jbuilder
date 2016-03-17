json.categories do
  json.array! @categories do |category|
    json.id category.id
    json.name category.name
    json.barance_of_payments category.barance_of_payments
    json.breakdowns do
      json.array! category.breakdowns do |breakdown|
        json.id breakdown.id
        json.name breakdown.name
      end
    end
    json.places do
      json.array! category.places do |place|
        json.id place.id
        json.name place.name
      end
    end
  end
end
