# frozen_string_literal: true
require 'rails_helper'

describe 'POST /session?email=email&password=password', autodoc: true do
  let!(:user) do
    create(:email_user, :registered,
           email: 'login@example.com', password: 'password')
  end
  let!(:email) { 'login@example.com' }
  let!(:password) { 'password' }
  let!(:params) { { email: email, password: password } }

  context 'ユーザーの本登録が完了している場合' do
    it '200が返ってくること' do
      post '/session', params: params
      expect(response.status).to eq 200

      json = {
        access_token: user.find_token_by_name(:access).token,
        user: {
          id: user.id,
          type: user.type,
          email: user.email,
          new_email: user.new_email,
          nickname: user.nickname,
          user_name: user._name,
          currency: user.currency,
          admin: user.admin,
          max_values: user.each_maximum_values
        }
      }
      expect(response.body).to be_json_as(json)
    end
  end

  context 'ユーザーの本登録が完了していない場合' do
    before do
      user.status = :inactive
      user.save
    end

    it '401とエラーメッセージが返ってくること' do
      post '/session', params: params

      expect(response.status).to eq 401
      json = {
        error_messages: ['メールアドレスまたはパスワードが正しくありません']
      }
      expect(response.body).to be_json_as(json)
    end
  end

  context 'ユーザーが見つからない場合' do
    let(:email) { 'dummy@example.com' }

    it '401とエラーメッセージが返ってくること' do
      post '/session', params: params

      expect(response.status).to eq 401
      json = {
        error_messages: ['メールアドレスまたはパスワードが正しくありません']
      }
      expect(response.body).to be_json_as(json)
    end
  end

  context 'パスワードが不正な場合' do
    let(:password) { 'dummy_password' }

    it '401とエラーメッセージが返ってくること' do
      post '/session', params: params

      expect(response.status).to eq 401
      json = {
        error_messages: ['メールアドレスまたはパスワードが正しくありません']
      }
      expect(response.body).to be_json_as(json)
    end
  end
end
