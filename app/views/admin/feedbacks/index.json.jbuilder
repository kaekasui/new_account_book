json.feedbacks do
  json.array! @feedbacks do |feedback|
    json.id feedback.id
    json.checked feedback.checked
    json.email feedback.email
    json.user_id feedback.user_id
    json.user_name feedback.user.try(:_name)
    json.content simple_format(feedback.content)
    json.created_at I18n.l(feedback.created_at)
  end
end

json.total_count @total_count
