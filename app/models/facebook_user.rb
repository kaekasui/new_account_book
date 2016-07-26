# frozen_string_literal: true
class FacebookUser < User
  has_one :auth, foreign_key: 'user_id'

  def self.create_with(auth)
    fb_user = create!(status: :inactive)
    fb_user.email = auth['info']['email']
    # TODO: fb_user.icon = auth['info']['image']
    auth_data = Auth.create!(
      provider: 'facebook',
      uid: auth['uid'],
      name: auth['info']['name']
    )
    fb_user.auth = auth_data
    fb_user
  end

  def _name
    nickname || auth.try(:name) || auth.try(:screen_name)
  end
end
