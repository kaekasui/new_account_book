json.tags do
  json.array! @tags do |tag|
    json.id tag.id
    json.color_code tag.color_code
    json.name tag.name
  end
end
