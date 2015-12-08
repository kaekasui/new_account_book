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
end
