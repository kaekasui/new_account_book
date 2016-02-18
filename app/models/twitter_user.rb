class TwitterUser < User
  has_one :auth, foreign_key: 'user_id'
end
