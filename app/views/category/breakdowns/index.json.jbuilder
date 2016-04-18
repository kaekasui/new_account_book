json.category do
  json.name @category.name
  json.barance_of_payments @category.barance_of_payments
end

json.breakdowns do
  json.array! @breakdowns do |breakdown|
    json.id breakdown.id
    json.name breakdown.name
  end
end
