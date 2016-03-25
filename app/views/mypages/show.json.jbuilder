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
