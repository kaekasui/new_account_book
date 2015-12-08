require 'rails_helper'

describe 'POST /email_user/registrations?email=email\
  &password=password&password_confirmation=password', autodoc: true do
  let!(:email) { 'login@example.com' }
  let!(:password) { 'password' }
  let!(:password_confirmation) { 'password' }
  let!(:params) do
    {
      email: email,
      password: password,
      password_confirmation: password_confirmation
    }
  end

  context '各値が正しい場合' do
    it '201が返ってくること' do
      post '/email_user/registrations', params

      expect(response.status).to eq 201

      user = User.last
      expect(user.status).to eq 'inactive'

      open_email(user.email)
      expect(current_email.subject).to eq '【PIG BOOK β】アカウント登録のご案内'
    end
  end

  context 'パスワードが空の場合' do
    let(:password) { '' }

    it '422とエラーメッセージが返ってくること' do
      post '/email_user/registrations', params

      expect(response.status).to eq 422
      json = {
        'error_messages': ['パスワードを入力してください']
      }
      expect(response.body).to be_json_as(json)
    end
  end

  context 'パスワードが一致しない場合' do
    let(:password) { 'dummy_password' }

    it '422とエラーメッセージが返ってくること' do
      post '/email_user/registrations', params

      expect(response.status).to eq 422
      json = {
        'error_messages': ['パスワード（確認）とパスワードの入力が一致しません']
      }
      expect(response.body).to be_json_as(json)
    end
  end
end
