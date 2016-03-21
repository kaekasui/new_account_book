json.records do
  json.array! @records do |record|
    json.id record.id
    json.charge record.charge
    json.category_name record.category.name
    json.breakdown_name record.breakdown.try(:name)
    json.place_name record.place.try(:name)
    json.memo record.memo
  end
end

json.total_count @total_count
