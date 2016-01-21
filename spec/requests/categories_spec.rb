require 'rails_helper'

describe 'GET /categories', autodoc: true do
  context 'ログインしていない場合' do
    it '401が返ってくること' do
      get '/categories'
      expect(response.status).to eq 401
    end
  end

  context 'メールアドレスのユーザーがログインしている場合' do
    let!(:user) { create(:email_user, :registered) }
    let!(:category) { create(:category, user: user) }
    let!(:category2) { create(:category, user: user) }

    it '200とカテゴリ一覧を返すこと' do
      get '/categories', '', login_headers(user)
      expect(response.status).to eq 200

      json = {
        categories: [
          {
            id: category.id,
            name: category.name
          },
          {
            id: category2.id,
            name: category2.name
          }
        ]
      }
      expect(response.body).to be_json_as(json)
    end
  end
end

describe 'POST /categories', autodoc: true do
  context 'ログインしていない場合' do
    it '401が返ってくること' do
      post '/categories'
      expect(response.status).to eq 401
    end
  end

  context 'メールアドレスのユーザーがログインしている場合' do
    let!(:user) { create(:email_user, :registered) }
    let!(:params) { { name: '名前' } }

    it '201を返し、カテゴリが登録できること' do
      post '/categories', params, login_headers(user)
      expect(response.status).to eq 201

      expect(user.categories.count).to eq 1
    end
  end
end

describe 'POST /categories/sort', autodoc: true do
  context 'ログインしていない場合' do
    it '401が返ってくること' do
      post '/categories/sort'
      expect(response.status).to eq 401
    end
  end

  context 'メールアドレスのユーザーがログインしている場合' do
    let!(:user) { create(:email_user, :registered) }
    let!(:category1) { create(:category, user: user) }
    let!(:category2) { create(:category, user: user) }
    let!(:category3) { create(:category, user: user) }
    let!(:category4) { create(:category, user: user) }
    let!(:params) do
      { sequence: [category3.id, category2.id, category4.id, category1.id] }
    end

    it '200を返し、データが正しいこと' do
      post '/categories/sort', params, login_headers(user)
      expect(response.status).to eq 200

      expect(user.categories.order(:position).map(&:id)).to eq params[:sequence]
    end
  end
end
