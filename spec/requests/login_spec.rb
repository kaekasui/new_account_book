require 'rails_helper'

describe 'POST /session?email=email&password=password', autodoc: true do
  let!(:user) do
    create(:user, email: 'login@example.com', password: 'password')
  end
  let!(:email) { 'login@example.com' }
  let!(:password) { 'password' }
  let!(:params) { { email: email, password: password } }

  context '各値が正しい場合' do
    it '200が返ってくること' do
      post '/session', params

      expect(response.status).to eq 200
    end
  end

  context 'ユーザーが見つからない場合' do
    let(:email) { 'dummy@example.com' }

    it '401とエラーメッセージが返ってくること' do
      post '/session', params

      expect(response.status).to eq 401
      json = {
        'error_messages': ['メールアドレスまたはパスワードが正しくありません。']
      }
      expect(response.body).to be_json_as(json)
    end
  end

  context 'パスワードが不正な場合' do
    let(:password) { 'dummy_password' }

    it '401とエラーメッセージが返ってくること' do
      post '/session', params

      expect(response.status).to eq 401
      json = {
        'error_messages': ['メールアドレスまたはパスワードが正しくありません。']
      }
      expect(response.body).to be_json_as(json)
    end
  end
end
