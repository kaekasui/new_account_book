if @error.message.present?
  json.error_messages [@error.message]
else
  json.error_messages ['Bad Request']
end
