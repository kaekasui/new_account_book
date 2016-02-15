json.breakdowns do
  json.array! @breakdowns do |breakdown|
    json.id breakdown.id
    json.name breakdown.name
  end
end
