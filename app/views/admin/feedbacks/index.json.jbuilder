json.feedbacks do
  json.array! @feedbacks do |feedback|
    json.checked feedback.checked
    json.email feedback.email
    json.user_name feedback.user_name
    json.content feedback.content
    json.created_at I18n.l(feedback.created_at)
  end
end

json.total_count @total_count
