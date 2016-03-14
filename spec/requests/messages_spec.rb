require 'rails_helper'

describe 'GET /messages/:id', autodoc: true do
  let!(:user) { create(:email_user, :registered) }

  context 'ログインしていない場合' do
    let!(:message) { create(:message, user: user) }

    it '401が返ってくること' do
      get "/messages/#{message.id}"
      expect(response.status).to eq 401
    end
  end

  context 'メールアドレスのユーザーがログインしている場合' do
    let!(:message) { create(:message, user: user) }

    it '200とメッセージを返すこと' do
      expect(message.read).to be_falsey

      get "/messages/#{message.id}", '', login_headers(user)
      expect(response.status).to eq 200

      json = {
        id: message.id,
        content: message.content,
        created_at: I18n.l(message.created_at)
      }
      expect(response.body).to be_json_as(json)
      message.reload
      expect(message.read).to be_truthy
    end
  end

  context '別のメールアドレスのユーザーがログインしている場合' do
    let!(:another_user) { create(:email_user, :registered) }
    let!(:message) { create(:message, user: user) }

    it '404を返すこと' do
      get "/messages/#{message.id}", '', login_headers(another_user)
      expect(response.status).to eq 404
    end
  end
end
