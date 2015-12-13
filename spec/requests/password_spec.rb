require 'rails_helper'

describe 'POST /email_user/passwords/send_mail?email=email', autodoc: true do
  let!(:email) { 'login@example.com' }

  context 'ユーザーが見つからない場合' do
    it '200が返り、メールが送信されること' do
      post "/email_user/passwords/send_mail?email=#{email}"
      expect(response.status).to eq 200

      open_email(email)
      expect(current_email.subject).to eq '【PIG BOOK β】アカウントのご確認と登録のご案内'
      expect(current_email).to have_content email
    end
  end

  context 'ユーザーが仮登録の場合' do
    let!(:user) { create(:email_user, :inactive, email: email) }

    it '200が返り、メールが送信されること' do
      post "/email_user/passwords/send_mail?email=#{email}"
      expect(response.status).to eq 200

      open_email(email)
      expect(current_email.subject).to eq '【PIG BOOK β】パスワードリセットのご案内'
      expect(current_email).to have_content email
    end
  end

  context 'ユーザーが登録済みの場合' do
    let!(:user) { create(:email_user, :registered, email: email) }

    it '200が返り、メールが送信されること' do
      post "/email_user/passwords/send_mail?email=#{email}"
      expect(response.status).to eq 200

      open_email(email)
      expect(current_email.subject).to eq '【PIG BOOK β】パスワードリセットのご案内'
      expect(current_email).to have_content email
    end
  end
end

describe 'GET /email_user/passwords/:id/edit?email=email', autodoc: true do
  let!(:email) { 'login@example.com' }

  context 'ユーザーが見つからない場合' do
    it '404が返ってくること' do
      get "/email_user/passwords/1/edit?token=#{email}"
      expect(response.status).to eq 404
    end
  end

  context 'パスワードトークンが不正だった場合' do
    let!(:user) { create(:email_user, :registered, email: email) }

    it '404が返ってくること' do
      post "/email_user/passwords/send_mail?email=#{email}"
      expect(response.status).to eq 200

      get "/email_user/passwords/#{user.id}/edit?token=dummy_token"
      expect(response.status).to eq 404
    end
  end

  context '接続URLが正しい場合' do
    let!(:user) { create(:email_user, :registered, email: email) }

    it '302が返ってくること' do
      post "/email_user/passwords/send_mail?email=#{email}"
      expect(response.status).to eq 200

      open_email(user.email)
      current_email.body =~ %r{\/passwords\/(\d*)\/edit\?token=(.*)\Z}
      user_id = Regexp.last_match(1)
      token = Regexp.last_match(2)

      get "/email_user/passwords/#{user_id}/edit?token=#{token}"
      expect(response.status).to eq 302
    end
  end
end
