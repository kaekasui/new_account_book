json.places do
  json.array! @places do |place|
    json.id place.id
    json.name place.name
    json.categories do
      json.array! place.categories do |category|
        json.name category.name
      end
    end
  end
end
