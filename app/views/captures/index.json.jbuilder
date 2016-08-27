json.captures do
  json.array! @captures do |capture|
    json.id capture.id
    json.created_at I18n.l(capture.created_at)
    json.published_at capture.published_at
    json.category_name capture.category_name
    json.category_existence capture.category_existence
    json.breakdown_name capture.breakdown_name
    json.breakdown_existence capture.breakdown_existence
    json.place_name capture.place_name
    json.place_existence capture.place_existence
    json.charge capture.charge
    json.memo capture.memo
    json.tags capture.tags
    json.comment capture.comment
  end
end

json.user_currency @user.currency
