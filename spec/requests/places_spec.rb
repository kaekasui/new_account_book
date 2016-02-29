require 'rails_helper'

describe 'GET /places', autodoc: true do
  context 'ログインしていない場合' do
    it '401が返ってくること' do
      get '/places'
      expect(response.status).to eq 401
    end
  end

  context 'メールアドレスのユーザーがログインしている場合' do
    let!(:user) { create(:email_user, :registered) }
    let!(:place) { create(:place, user: user) }
    let!(:place2) { create(:place, user: user) }

    it '200と場所一覧を返すこと' do
      get '/places', '', login_headers(user)
      expect(response.status).to eq 200

      json = {
        places: [
          {
            id: place.id,
            name: place.name
          },
          {
            id: place2.id,
            name: place2.name
          }
        ]
      }
      expect(response.body).to be_json_as(json)
    end
  end
end
