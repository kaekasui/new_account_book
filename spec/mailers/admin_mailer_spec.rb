require 'rails_helper'

RSpec.describe AdminMailer do
  describe '#notice_feedback' do
    let!(:email) { 'email@example.com' }
    let(:mail) { AdminMailer.notice_feedback(feedback) }

    context 'ログインしているユーザーからのフィードバックの場合' do
      let!(:feedback) { create(:feedback, :login_user) }

      it 'ヘッダが正しいこと' do
        expect(mail.subject).to eq 'フィードバックが届きました'
        expect(mail.to).to eq [Settings.mail_from]
        expect(mail.from).to eq [Settings.mail_from]
      end
    end

    context 'ログインしていないユーザーからのフィードバックの場合' do
      let!(:feedback) { create(:feedback) }

      it 'ヘッダが正しいこと' do
        expect(mail.subject).to eq 'フィードバックが届きました'
        expect(mail.to).to eq [Settings.mail_from]
        expect(mail.from).to eq [Settings.mail_from]
      end
    end
  end
end
