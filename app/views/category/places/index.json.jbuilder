json.places do
  json.array! @places do |place|
    json.id place.id
    json.name place.name
  end
end
