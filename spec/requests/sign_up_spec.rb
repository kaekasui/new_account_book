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
      clear_emails
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

describe 'PATCH /email_user/registrations/:id?token=token', autodoc: true do
  let!(:params) do
    {
      email: 'login@example.com',
      password: 'password',
      password_confirmation: 'password'
    }
  end

  before do
    post '/email_user/registrations', params
    open_email('login@example.com')
    current_email.body =~ %r{\/registrations\/(\d*)\?token=(.*)\Z}
    @user_id = Regexp.last_match(1)
    @token = Regexp.last_match(2)
  end

  context 'リンクが有効な場合' do
    it '200が返り、メールが送信されること' do
      clear_emails
      patch "/email_user/registrations/#{@user_id}?token=#{@token}"
      expect(response.status).to eq 200

      user = User.last
      expect(user.status).to eq 'registered'

      open_email(user.email)
      expect(current_email.subject).to eq '【PIG BOOK β】アカウント登録完了のお知らせ'
      expect(current_email).to have_content user.email
    end

    it 'ログインできるようになっていること' do
      patch "/email_user/registrations/#{@user_id}", token: @token
      expect(response.status).to eq 200

      post '/session', params
      expect(response.status).to eq 200
    end
  end

  context 'ユーザーが見つからない場合' do
    it '404が返ってくること' do
      patch '/email_user/registrations/1', params
      expect(response.status).to eq 404
    end
  end

  context 'トークンの有効期限が切れていた場合' do
    it '401が返ってくること' do
      Timecop.travel(2.days.since)
      patch "/email_user/registrations/#{@user_id}", token: @token
      expect(response.status).to eq 401
      Timecop.return
    end
  end

  context 'トークンが不正だった場合' do
    it '401が返ってくること' do
      patch "/email_user/registrations/#{@user_id}", token: "invalid#{@token}"
      expect(response.status).to eq 401
    end
  end

  context 'すでに登録が完了していた場合' do
    it '401が返ってくること' do
      patch "/email_user/registrations/#{@user_id}", token: @token
      expect(response.status).to eq 200

      patch "/email_user/registrations/#{@user_id}", token: @token
      expect(response.status).to eq 401
    end
  end
end

describe 'POST /email_user/registrations/recreate?email=email', autodoc: true do
  let!(:email) { 'login@example.com' }
  let!(:user) { create(:email_user, :inactive, email: 'login@example.com') }

  context 'メールアドレスが正しい場合' do
    it '200が返り、メールが送信されること' do
      clear_emails
      patch '/email_user/registrations/recreate', email: email
      expect(response.status).to eq 200

      open_email(email)
      expect(current_email.subject).to eq '【PIG BOOK β】アカウント登録のご案内'
    end
  end

  context 'すでに登録が完了していたメールアドレスの場合' do
    before do
      user.status = :registered
      user.save
    end

    it '404が返ってくること' do
      patch '/email_user/registrations/recreate', email: email
      expect(response.status).to eq 404
    end
  end

  context 'メールアドレスが登録されていない場合' do
    it '404が返ってくること' do
      patch '/email_user/registrations/recreate', email: "dummy#{email}"
      expect(response.status).to eq 404
    end
  end

  context 'メールアドレスが空の場合' do
    let(:email) { '' }

    it '422が返ってくること' do
      patch '/email_user/registrations/recreate', email: email
      expect(response.status).to eq 422
      json = {
        'error_messages': ['メールアドレスを入力してください']
      }
      expect(response.body).to be_json_as(json)
    end
  end
end
