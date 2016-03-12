json.feedbacks do
  json.array! @feedbacks do |feedback|
    json.id feedback.id
    json.content feedback.content
    json.checked feedback.checked
  end
end

json.user_name @user._name
