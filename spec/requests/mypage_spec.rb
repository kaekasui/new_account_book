require 'rails_helper'

describe 'GET /user', autodoc: true do
  let!(:email) { 'login@example.com' }

  context 'ログインしていない場合' do
    it '401が返ってくること' do
      get '/user'
      expect(response.status).to eq 401
    end
  end

  context 'メールアドレスのユーザーがログインしている場合' do
    let!(:user) { create(:email_user, :registered, email: email) }

    it '200とユーザー情報を返すこと' do
      get '/user', '', login_headers(user)
      expect(response.status).to eq 200

      json = {
        id: user.id,
        type: user.type,
        email: user.email,
        admin: user.admin
      }
      expect(response.body).to be_json_as(json)
    end
  end
end

describe 'PATCH /user', autodoc: true do
  context 'ログインしていない場合' do
    it '401が返ってくること' do
      patch '/user'
      expect(response.status).to eq 401
    end
  end

  context 'メールアドレスのユーザーがログインしている場合' do
    let!(:user) { create(:email_user, :registered) }

    context 'ニックネームが空でない場合' do
      let!(:params) { { nickname: 'ニックネーム' } }
  
      it '200とユーザー情報を返すこと' do
        patch '/user', params, login_headers(user)
        expect(response.status).to eq 200
  
        user.reload
        expect(user.nickname).to eq 'ニックネーム'
      end
    end
  end
end
