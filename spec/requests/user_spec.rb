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
        admin: user.admin,
        date_setting: user.date_setting
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

describe 'PATCH /user/set_display', autodoc: true do
  context 'ログインしていない場合' do
    it '401が返ってくること' do
      patch '/user/set_display'
      expect(response.status).to eq 401
    end
  end

  context 'メールアドレスのユーザーがログインしている場合' do
    let!(:user) { create(:email_user, :registered) }

    context '内訳を非表示にした時' do
      let!(:params) { { breakdown_field: false } }

      it '200が返ってくること' do
        expect(user.breakdown_field).to be_truthy
        patch '/user/set_display', params, login_headers(user)
        expect(response.status).to eq 200

        user.reload
        expect(user.breakdown_field).to be_falsey
      end
    end

    context 'お店・施設を表示にした時' do
      let!(:params) { { place_field: true } }

      it '200が返ってくること' do
        expect(user.place_field).to be_truthy
        patch '/user/set_display', params, login_headers(user)
        expect(response.status).to eq 200

        user.reload
        expect(user.place_field).to be_truthy
      end
    end
  end
end
