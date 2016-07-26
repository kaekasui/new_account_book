# frozen_string_literal: true
require 'rails_helper'

# パスワードを変更するためにメール送信
describe 'POST /email_user/password/send_mail?email=email', autodoc: true do
  let!(:email) { 'login@example.com' }
  let!(:email_param) { { email: email } }

  context 'メールアドレスが空の場合' do
    let(:email) { '' }

    it '422が返ってくること' do
      post '/email_user/password/send_mail', params: email_param
      expect(response.status).to eq 422
    end
  end

  context 'ユーザーが見つからない場合' do
    it '200が返り、メールが送信されること' do
      post '/email_user/password/send_mail', params: email_param
      expect(response.status).to eq 200

      open_email(email)
      expect(current_email.subject).to eq '【PIG BOOK β】アカウントのご確認と登録のご案内'
      expect(current_email).to have_content email
      expect(current_email).not_to have_content '/email_user/password/edit?'
    end
  end

  context 'ユーザーが仮登録の場合' do
    let!(:user) { create(:email_user, :inactive, email: email) }

    it '200が返り、メールが送信されること' do
      post '/email_user/password/send_mail', params: email_param
      expect(response.status).to eq 200

      open_email(email)
      expect(current_email.subject).to eq '【PIG BOOK β】アカウント登録状況のご確認と登録のご案内'
      expect(current_email).to have_content email
      expect(current_email).not_to have_content '/email_user/password/edit?'
    end
  end

  context 'ユーザーが登録済みの場合' do
    let!(:user) { create(:email_user, :registered, email: email) }

    it '200が返り、メールが送信されること' do
      post '/email_user/password/send_mail', params: email_param
      expect(response.status).to eq 200

      open_email(email)
      expect(current_email.subject).to eq '【PIG BOOK β】パスワードリセットのご案内'
      expect(current_email).to have_content email
      expect(current_email).to have_content '/email_user/password/edit?'
    end
  end
end

# パスワードの変更画面
describe 'GET /email_user/password/edit?email=email&token=token',
         autodoc: true do
  let!(:email) { 'login@example.com' }
  let!(:token) { 'dummy_token' }
  let!(:email_param) { { email: email } }
  let!(:params) { { email: email, token: token } }

  context 'ユーザーが見つからない場合' do
    let(:email) { '' }

    it '302が返ってくること' do
      get '/email_user/password/edit', params: params
      expect(response.status).to eq 302
    end
  end

  context 'パスワードトークンが不正だった場合' do
    let!(:user) { create(:email_user, :registered, email: email) }

    it '302が返ってくること' do
      post '/email_user/password/send_mail', params: email_param
      expect(response.status).to eq 200

      get '/email_user/password/edit', params: params
      expect(response.status).to eq 302
    end
  end

  context '接続URLが正しい場合' do
    let!(:user) { create(:email_user, :registered, email: email) }

    it '302が返ってくること' do
      post '/email_user/password/send_mail?', params: email_param
      expect(response.status).to eq 200

      open_email(user.email)
      current_email.body =~ %r{\/password\/edit\?token=(.*)}
      token = Regexp.last_match(1)

      params = { email: user.email, token: token }
      get '/email_user/password/edit', params: params
      expect(response.status).to eq 302
    end
  end
end

# ログインなしでパスワードを変更
describe 'PATCH /email_user/password
  ?password=password&\password_confirmation=password_confirmation\
  &token=token', autodoc: true do
  let!(:user) { create(:email_user, :registered, email: email) }
  let!(:email) { 'login@example.com' }
  let!(:email_param) { { email: email } }
  let!(:password) { 'password' }
  let!(:new_password) { 'newpassword' }
  let!(:params) do
    {
      password: new_password,
      password_confirmation: new_password
    }
  end

  context 'ユーザーが見つからない場合' do
    it '422が返ってくること' do
      patch '/email_user/password', params: params
      expect(response.status).to eq 422

      json = {
        error_messages: ['アカウントが無効、または有効期限が切れたURLからの接続です。']
      }
      expect(response.body).to be_json_as(json)
    end
  end

  context '新しいパスワードが確認と一致しない場合' do
    it '422が返ってくること' do
      post '/email_user/password/send_mail?', params: email_param
      expect(response.status).to eq 200

      open_email(user.email)
      current_email.body =~ %r{\/password\/edit\?token=(.*)}
      token = Regexp.last_match(1)

      get '/email_user/password/edit', params: { token: token }
      expect(response.status).to eq 302
      params[:password] = 'invalid_password'

      patch '/email_user/password', params: params.merge(token: token)
      expect(response.status).to eq 422

      json = {
        error_messages: ['パスワード（確認）とパスワードの入力が一致しません']
      }
      expect(response.body).to be_json_as(json)
    end
  end

  context 'トークンが正しくない場合' do
    it '422が返ってくること' do
      post '/email_user/password/send_mail?', params: email_param
      expect(response.status).to eq 200

      open_email(user.email)
      current_email.body =~ %r{\/password\/edit\?token=(.*)}
      token = Regexp.last_match(1)

      get '/email_user/password/edit', params: { token: token }
      expect(response.status).to eq 302

      patch '/email_user/password', params: params.merge(token: 'dummy')
      expect(response.status).to eq 422

      json = {
        error_messages: ['アカウントが無効、または有効期限が切れたURLからの接続です。']
      }
      expect(response.body).to be_json_as(json)
    end
  end

  context '各値が正しい場合' do
    let!(:login_params) do
      { email: email, password: new_password }
    end

    it '200が返り、ログインできること' do
      post '/email_user/password/send_mail?', params: email_param
      expect(response.status).to eq 200

      open_email(user.email)
      current_email.body =~ %r{\/password\/edit\?token=(.*)}
      token = Regexp.last_match(1)

      get '/email_user/password/edit', params: { token: token }
      expect(response.status).to eq 302

      patch '/email_user/password', params: params.merge(token: token)
      expect(response.status).to eq 200

      post '/session', params: login_params
      expect(response.status).to eq 200
    end
  end
end
