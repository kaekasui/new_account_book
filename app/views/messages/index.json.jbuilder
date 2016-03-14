json.messages do
  json.array! @messages do |message|
    json.id message.id
    json.content message.content
    json.read message.read
    json.created_at I18n.l(message.created_at)
  end
end
