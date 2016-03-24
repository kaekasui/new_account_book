json.records do
  json.array! @records do |record|
    json.id record.id
    json.published_at record.published_at
    json.charge record.charge
    json.category_name record.category.name
    json.breakdown_name record.breakdown.try(:name)
    json.place_name record.place.try(:name)
    json.memo record.memo
  end
end

json.total_count @total_count
json.date_setting @date_setting
