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

describe 'POST /places?name=name', autodoc: true do
  let!(:place_name) { '東京総合病院' }
  let!(:params) { { name: place_name } }

  context 'ログインしていない場合' do
    context '各値が正しい場合' do
      it '401が返ってくること' do
        post '/places', params
        expect(response.status).to eq 401
      end
    end
  end

  context 'ログインしている場合' do
    let!(:user) { create(:user, :registered) }

    context '各値が正しい場合' do
      it '201が返ってくること' do
        post '/places', params, login_headers(user)
        expect(response.status).to eq 201
      end
    end

    context '名称が空の場合' do
      let(:place_name) { '' }

      it '422とエラーメッセージが返ってくること' do
        post '/places', params, login_headers(user)
        expect(response.status).to eq 422
        json = {
          error_messages: ['お店・施設名を入力してください']
        }
        expect(response.body).to be_json_as(json)
      end
    end
  end
end
