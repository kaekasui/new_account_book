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

describe 'POST /categories/:category_id/places', autodoc: true do
  let!(:user) { create(:email_user, :registered) }
  let!(:category) { create(:category, user: user) }

  context 'ログインしていない場合' do
    it '401が返ってくること' do
      post "/categories/#{category.id}/places"
      expect(response.status).to eq 401
    end
  end

  context 'メールアドレスのユーザーがログインしている場合' do
    let!(:place_name) { '場所' }
    let!(:params) { { name: place_name } }
    let!(:place) { create(:place, name: place_name, user: user) }

    context 'すでに登録されている施設名の場合' do
      it '200が返り、施設情報が返ってくること' do
        post "/categories/#{category.id}/places", params, login_headers(user)
        expect(response.status).to eq 200

        json = {
          id: place.id
        }
        expect(response.body).to be_json_as(json)
      end
    end

    context 'すでに登録、紐付けされている施設名の場合' do
      let!(:categorize_place) do
        create(:categorize_place, category: category, place: place)
      end

      it '422とエラーメッセージが返ってくること' do
        post "/categories/#{category.id}/places", params, login_headers(user)
        expect(response.status).to eq 422

        json = {
          error_messages: ['カテゴリとの関係はすでに存在します']
        }
        expect(response.body).to be_json_as(json)
      end
    end

    context '新たに設定された施設名の場合' do
      let!(:params) { { name: '新規' } }

      it '200が返り、施設情報が返ってくること' do
        post "/categories/#{category.id}/places", params, login_headers(user)
        expect(response.status).to eq 200

        place = Place.find_by(name: '新規')
        json = {
          id: place.id
        }
        expect(response.body).to be_json_as(json)
      end
    end
  end
end
