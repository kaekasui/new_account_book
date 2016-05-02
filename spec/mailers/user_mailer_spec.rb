require 'rails_helper'

RSpec.describe UserMailer do
  describe '#registration' do
    let!(:email) { 'email@example.com' }
    let!(:registration_url) { 'https://example.com/registration' }
    let(:mail) { UserMailer.registration(email, registration_url) }

    it 'ヘッダが正しいこと' do
      expect(mail.subject).to eq '【PIG BOOK β】アカウント登録のご案内'
      expect(mail.to).to eq [email]
      expect(mail.from).to eq [Settings.mail_from]
      expect(mail.body).to have_content(registration_url)
    end
  end

  describe '#finished_registration' do
    let!(:email) { 'email@example.com' }
    let(:mail) { UserMailer.finished_registration(email) }

    it 'ヘッダが正しいこと' do
      expect(mail.subject).to eq '【PIG BOOK β】アカウント登録完了のお知らせ'
      expect(mail.to).to eq [email]
      expect(mail.from).to eq [Settings.mail_from]
      expect(mail.body).to have_content(email)
    end
  end

  describe '#password_reset' do
    let!(:email) { 'email@example.com' }
    let!(:password_reset_url) { 'https://example.com/password_reset' }
    let(:mail) { UserMailer.password_reset(email, password_reset_url) }

    it 'ヘッダが正しいこと' do
      expect(mail.subject).to eq '【PIG BOOK β】パスワードリセットのご案内'
      expect(mail.to).to eq [email]
      expect(mail.from).to eq [Settings.mail_from]
      expect(mail.body).to have_content(password_reset_url)
    end
  end

  describe '#set_new_email' do
    let!(:email) { 'email@example.com' }
    let!(:new_email_url) { 'https://example.com/new_email_url' }
    let(:mail) { UserMailer.set_new_email(email, new_email_url) }

    it 'ヘッダが正しいこと' do
      expect(mail.subject).to eq '【PIG BOOK β】メールアドレス変更のご案内'
      expect(mail.to).to eq [email]
      expect(mail.from).to eq [Settings.mail_from]
      expect(mail.body).to have_content(new_email_url)
    end
  end

  describe '#confirm_account' do
    let!(:email) { 'email@example.com' }
    let(:mail) do
      UserMailer.confirm_account(email, 'https://example.com/')
    end

    it 'ヘッダが正しいこと' do
      expect(mail.subject).to eq '【PIG BOOK β】アカウントのご確認と登録のご案内'
      expect(mail.to).to eq [email]
      expect(mail.from).to eq [Settings.mail_from]
      expect(mail.body).to have_content(email)
    end
  end

  describe '#confirm_registration' do
    let!(:email) { 'email@example.com' }
    let(:mail) do
      UserMailer.confirm_registration(email, 'https://example.com/')
    end

    it 'ヘッダが正しいこと' do
      expect(mail.subject).to eq '【PIG BOOK β】アカウント登録状況のご確認と登録のご案内'
      expect(mail.to).to eq [email]
      expect(mail.from).to eq [Settings.mail_from]
      expect(mail.body).to have_content(email)
    end
  end

  describe '#confirm_message' do
    let!(:email) { 'email@example.com' }
    let(:mail) do
      UserMailer.confirm_message(email, 'https://example.com/')
    end

    it 'ヘッダが正しいこと' do
      expect(mail.subject).to eq '【PIG BOOK β】新しいメッセージが届いています'
      expect(mail.to).to eq [email]
      expect(mail.from).to eq [Settings.mail_from]
      expect(mail.body).to have_content(email)
    end
  end
end
