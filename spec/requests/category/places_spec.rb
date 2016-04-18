require 'rails_helper'

describe 'GET /categories/:category_id/places', autodoc: true do
  let!(:user) { create(:email_user, :registered) }
  let!(:category) { create(:category, user: user) }

  context 'ログインしていない場合' do
    it '401が返ってくること' do
      get "/categories/#{category.id}/places"
      expect(response.status).to eq 401
    end
  end

  context 'メールアドレスのユーザーがログインしている場合' do
    let!(:place) { create(:place, user: user) }
    let!(:place2) { create(:place, user: user) }

    it '200と場所一覧を返すこと' do
      place.categories << category
      place.save

      get "/categories/#{category.id}/places", '', login_headers(user)
      expect(response.status).to eq 200

      json = {
        category: {
          name: category.name,
          barance_of_payments: category.barance_of_payments
        },
        places: [
          {
            id: place.id,
            name: place.name
          }
        ]
      }
      expect(response.body).to be_json_as(json)
    end
  end
end
