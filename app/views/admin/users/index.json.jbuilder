json.users do
  json.array! @users do |user|
    json.id user.id
    json.admin user.admin?
    json.status user._status
    json.type user._type
    json.email user.email
  end
end
