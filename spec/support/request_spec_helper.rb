# frozen_string_literal: true
module RequestSpecHelper
  def login_headers(user)
    valid_token = user.find_token_by_name(:access)
    valid_token ||= user.add_access_token
    { Authorization: ActionController::HttpAuthentication::Token\
      .encode_credentials(valid_token.token) }
  end
end
