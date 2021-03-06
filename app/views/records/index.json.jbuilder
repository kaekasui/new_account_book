json.records do
  json.array! @records do |record|
    json.id record.id
    json.published_at record.published_at
    json.payments record.category.barance_of_payments
    json.charge record.charge
    json.category_id record.category.id
    json.category_name record.category.name
    json.breakdown_name record.breakdown.try(:name)
    json.place_name record.place.try(:name)
    json.memo record.memo
    json.tags record.tags do |tag|
      json.id tag.id
      json.name tag.name
      json.color_code tag.color_code
    end
  end
end

json.total_count @total_count

json.user do
  json.currency @user.currency
end
