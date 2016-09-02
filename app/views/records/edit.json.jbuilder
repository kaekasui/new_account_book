json.categories do
  json.array! @categories do |category|
    json.id category.id
    json.name category.name
    json.barance_of_payments category.barance_of_payments
    json._payments_name category._payments_name
    json.breakdowns do
      json.array! category.breakdowns do |breakdown|
        json.id breakdown.id
        json.name breakdown.name
      end
    end
    json.places do
      json.array! category.places do |place|
        json.id place.id
        json.name place.name
      end
    end
  end
end

json.user do
  json.breakdown_field @user.breakdown_field
  json.place_field @user.place_field
  json.tag_field @user.tag_field
  json.memo_field @user.memo_field
  json.currency @user.currency
end

json.record do
  json.id @record.id
  json.published_at @record.published_at
  json.payments @record.category.barance_of_payments
  json.charge @record.charge
  json.category_name @record.category.name
  json.breakdown_name @record.breakdown.try(:name)
  json.place_name @record.place.try(:name)
  json.memo @record.memo
  json.tags @record.tags
end
