require 'rails_helper'

describe 'POST /feedback?user_id=user_id&email=email&content=content',
         autodoc: true do
  let!(:content) { '問い合わせ内容' }

  context 'ログインしている場合' do
    let!(:user) { create(:user, :registered) }
    let!(:params) { { user_id: user.id, content: content } }

    context '各値が正しい場合' do
      it '201が返ってくること' do
        post '/feedback', params
        expect(response.status).to eq 201

        open_email(Settings.mail_from)
        expect(current_email.subject).to eq 'フィードバックが届きました'
      end
    end

    context '内容が空の場合' do
      let(:content) { '' }

      it '422とエラーメッセージが返ってくること' do
        post '/feedback', params
        expect(response.status).to eq 422
        json = {
          'error_messages': ['内容を入力してください']
        }
        expect(response.body).to be_json_as(json)
      end
    end
  end

  context 'ログインしていない場合' do
    let!(:email) { 'general_user@example.com' }
    let!(:params) { { email: email, content: content } }

    context '各値が正しい場合' do
      it '201が返ってくること' do
        post '/feedback', params
        expect(response.status).to eq 201
        expect(Feedback.last.content).to eq content

        open_email(Settings.mail_from)
        expect(current_email.subject).to eq 'フィードバックが届きました'
      end
    end

    context 'メールアドレスが空の場合' do
      let(:email) { '' }

      it '422とエラーメッセージが返ってくること' do
        post '/feedback', params
        expect(response.status).to eq 422
        json = {
          'error_messages': ['メールアドレスを入力してください']
        }
        expect(response.body).to be_json_as(json)
      end
    end

    context '内容が空の場合' do
      let(:content) { '' }

      it '422とエラーメッセージが返ってくること' do
        post '/feedback', params
        expect(response.status).to eq 422
        json = {
          'error_messages': ['内容を入力してください']
        }
        expect(response.body).to be_json_as(json)
      end
    end
  end
end
