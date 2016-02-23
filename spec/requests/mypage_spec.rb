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
        nickname: user.nickname,
        user_name: user._name,
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

    context 'ニックネームを設定した場合' do
      let!(:params) { { nickname: 'ニックネーム' } }

      it '200が返りデータが更新されること' do
        patch '/user', params, login_headers(user)
        expect(response.status).to eq 200

        user.reload
        expect(user.nickname).to eq 'ニックネーム'
      end
    end
  end
end

describe 'GET /notices', autodoc: true do
  context 'ログインしていない場合' do
    it '401が返ってくること' do
      get '/user'
      expect(response.status).to eq 401
    end
  end

  context 'ユーザーにお知らせがある場合' do
    let!(:user) { create(:email_user, :registered) }
    let!(:notice1) { create(:notice, post_at: Time.zone.today) }
    let!(:notice2) { create(:notice, post_at: Time.zone.yesterday) }
    let!(:notice3) { create(:notice, post_at: Time.zone.tomorrow) }

    it '200とお知らせ情報を返すこと' do
      get '/notices', '', login_headers(user)
      expect(response.status).to eq 200

      json = {
        notices: [
          {
            id: notice1.id,
            title: notice1.title,
            content: notice1.content,
            post_at: notice1.post_at.strftime('%Y-%m-%d')
          },
          {
            id: notice2.id,
            title: notice2.title,
            content: notice2.content,
            post_at: notice2.post_at.strftime('%Y-%m-%d')
          }
        ]
      }
      expect(response.body).to be_json_as(json)
    end
  end
end
