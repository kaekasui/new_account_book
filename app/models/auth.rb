# frozen_string_literal: true
class Auth < ActiveRecord::Base
  belongs_to :twitter_user, foreign_key: 'user_id'
  belongs_to :facebook_user, foreign_key: 'user_id'
end
