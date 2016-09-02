json.notices do
  json.array! @notices do |notice|
    json.id notice.id
    json.title notice.title
    json.content notice.content
    json.post_at notice.post_at
  end
end

json.messages do
  json.array! @messages do |message|
    json.id message.id
    json.content message.content
    json.read message.read
    json.created_at I18n.l(message.created_at)
  end
end

json.records do
  json.array! @records do |record|
    json.id record.id
    json.published_at record.published_at
    json.charge record.charge
    json.payments record.category.barance_of_payments
    json.category_name record.category.name
    json.breakdown_name record.breakdown.try(:name)
    json.place_name record.place.try(:name)
    json.memo record.memo
  end
end

json.user do
  json.currency @user.currency
end
