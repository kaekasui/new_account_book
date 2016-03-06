json.income_categories do
  json.array! @income_categories do |category|
    json.id category.id
    json.name category.name
    json.selected_place category.selected_place?(@place.id)
  end
end

json.outgo_categories do
  json.array! @outgo_categories do |category|
    json.id category.id
    json.name category.name
    json.selected_place category.selected_place?(@place.id)
  end
end
