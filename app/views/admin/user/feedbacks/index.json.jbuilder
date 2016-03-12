json.feedbacks do
  json.array! @feedbacks do |feedback|
    json.id feedback.id
    json.content simple_format(feedback.content)
  end
end
