class TwitterUser < User
  has_one :auth, foreign_key: 'user_id'

  def self.create_with(auth)
    twitter_user = create!(status: :inactive)
    auth_data = Auth.create!(
      provider: 'twitter',
      uid: auth['uid'],
      screen_name: auth['info']['nickname'],
      name: auth['info']['name']
    )
    twitter_user.auth = auth_data
    twitter_user
  end

  def _name
    nickname || auth.try(:name) || auth.try(:screen_name)
  end
end
