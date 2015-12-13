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
