json.messages do
  json.array! @messages do |message|
    json.id message.id
    json.content message.content
  end
end

json.total_count @total_count
