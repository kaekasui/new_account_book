json.messages do
  json.array! @messages do |message|
    json.id message.id
    json.user_name message.user._name
    json.feedback_content message.feedback.try(:content)
    json.content message.content
  end
end

json.total_count @total_count
