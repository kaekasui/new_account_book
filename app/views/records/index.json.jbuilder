json.records do
  json.array! @records do |record|
    json.id record.id
  end
end
