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
    let!(:category) { create(:category, user: user) }

    it '200と場所一覧を返すこと' do
      pending
      place.categories << category
      place.save

      get '/places', '', login_headers(user)
      expect(response.status).to eq 200

      json = {
        places: [
          {
            id: place2.id,
            name: place2.name,
            categories: []
          },
          {
            id: place.id,
            name: place.name,
            categories: [
              id: category.id,
              name: category.name,
              barance_of_payments: category.barance_of_payments
            ]
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
          error_messages: ['お店・施設は不正な値です']
        }
        expect(response.body).to be_json_as(json)
      end
    end

    context 'お店・施設が作成上限に達した場合' do
      it '422とエラーメッセージが返ってくること' do
        3.times { create(:place, user: user) }

        post '/places', params, login_headers(user)
        expect(response.status).to eq 422
        json = {
          error_messages: ['お店・施設の作成上限は3件です']
        }
        expect(response.body).to be_json_as(json)
      end
    end
  end
end

describe 'PATCH /places/:id', autodoc: true do
  let!(:user) { create(:email_user, :registered) }
  let!(:place) { create(:place, user: user) }

  context 'ログインしていない場合' do
    it '401が返ってくること' do
      patch "/places/#{place.id}"
      expect(response.status).to eq 401
    end
  end

  context 'メールアドレスのユーザーがログインしている場合' do
    context '場所・施設名の値が正しい場合' do
      let!(:params) { { name: '名前' } }

      it '200を返し、お店・施設が登録できること' do
        patch "/places/#{place.id}", params, login_headers(user)
        expect(response.status).to eq 200

        place.reload
        expect(place.name).to eq params[:name]
      end
    end

    context '場所・施設名の値が空の場合' do
      let!(:params) { { name: '' } }

      it '422を返し、お店・施設が登録できないこと' do
        patch "/places/#{place.id}", params, login_headers(user)
        expect(response.status).to eq 422

        json = {
          error_messages: ['お店・施設名を入力してください']
        }
        expect(response.body).to be_json_as(json)
      end
    end
  end
end

describe 'DELETE /places/:id', autodoc: true do
  let!(:user) { create(:email_user, :registered) }
  let!(:category) { create(:category, user: user) }
  let!(:place) { create(:place, user: user) }

  context 'ログインしていない場合' do
    it '401が返ってくること' do
      delete "/places/#{place.id}"
      expect(response.status).to eq 401
    end
  end

  context 'メールアドレスのユーザーがログインしている場合' do
    it '200を返し、お店・施設が削除できること' do
      delete "/places/#{place.id}", '', login_headers(user)
      expect(response.status).to eq 200

      expect(Place.count).to eq 0
    end
  end

  context '削除対象のカテゴリが複数の内訳を登録していた場合' do
    before do
      place.categories << category
      place.save
    end

    it '200を返し、お店・施設が削除できること' do
      expect(category.places).to eq [place]

      delete "/places/#{place.id}", '', login_headers(user)
      expect(response.status).to eq 200

      category.reload
      expect(Place.count).to eq 0
      expect(category.places).to eq []
    end
  end
end
