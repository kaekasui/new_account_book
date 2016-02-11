json.categories do
  json.array! @categories do |category|
    json.id category.id
    json.name category.name
    json.breakdowns_count category.breakdowns.count
  end
end
