require 'rails_helper'

describe 'GET /users/:id', autodoc: true do
  let!(:email) { 'login@example.com' }

  context 'メールアドレスのユーザーの場合' do
    let!(:user) { create(:email_user, :registered, email: email) }

    it '200とユーザー情報を返すこと' do
      get "/users/#{user.id}", '', login_headers(user)
      expect(response.status).to eq 200

      json = {
        id: user.id
      }
      expect(response.body).to be_json_as(json)
    end
  end
end
