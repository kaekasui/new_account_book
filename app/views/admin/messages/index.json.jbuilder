json.messages do
  json.array! @messages do |message|
    json.id message.id
    json.read message.read
    json.sent_at message.sent_at ? I18n.l(message.sent_at) : ''
    json.user_name message.user._name
    json.feedback_content message.feedback.try(:content)
    json.content message.content
    json.created_at I18n.l(message.created_at)
  end
end

json.total_count @total_count
