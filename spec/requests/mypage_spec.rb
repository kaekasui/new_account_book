require 'rails_helper'

describe 'GET /mypage', autodoc: true do
  context 'ログインしていない場合' do
    it '401が返ってくること' do
      get '/user'
      expect(response.status).to eq 401
    end
  end

  context 'ユーザーにお知らせとメッセージがある場合' do
    let!(:user) { create(:email_user, :registered) }
    let!(:user2) { create(:email_user, :registered) }
    let!(:notice1) { create(:notice, post_at: Time.zone.today) }
    let!(:notice2) { create(:notice, post_at: Time.zone.yesterday) }
    let!(:notice3) { create(:notice, post_at: Time.zone.tomorrow) }
    let!(:message1) { create(:message, user: user, read: true) }
    let!(:message2) { create(:message, user: user2) }
    let!(:message3) { create(:message, user: user) }

    it '200とお知らせ情報、メッセージ情報を返すこと' do
      get '/mypage', '', login_headers(user)
      expect(response.status).to eq 200

      json = {
        notices: [
          {
            id: notice1.id,
            title: notice1.title,
            content: notice1.content,
            post_at: notice1.post_at.strftime('%Y-%m-%d')
          },
          {
            id: notice2.id,
            title: notice2.title,
            content: notice2.content,
            post_at: notice2.post_at.strftime('%Y-%m-%d')
          }
        ],
        messages: [
          {
            id: message3.id,
            content: message3.content,
            read: false,
            created_at: I18n.l(message3.created_at)
          },
          {
            id: message1.id,
            content: message1.content,
            read: true,
            created_at: I18n.l(message1.created_at)
          }
        ]
      }
      expect(response.body).to be_json_as(json)
    end
  end
end

describe 'GET /notices', autodoc: true do
  context 'ログインしていない場合' do
    it '401が返ってくること' do
      get '/user'
      expect(response.status).to eq 401
    end
  end

  context 'ユーザーにお知らせがある場合' do
    let!(:user) { create(:email_user, :registered) }
    let!(:notice1) { create(:notice, post_at: Time.zone.today) }
    let!(:notice2) { create(:notice, post_at: Time.zone.yesterday) }
    let!(:notice3) { create(:notice, post_at: Time.zone.tomorrow) }

    it '200とお知らせ情報を返すこと' do
      get '/notices', '', login_headers(user)
      expect(response.status).to eq 200

      json = {
        notices: [
          {
            id: notice1.id,
            title: notice1.title,
            content: notice1.content,
            post_at: notice1.post_at.strftime('%Y-%m-%d')
          },
          {
            id: notice2.id,
            title: notice2.title,
            content: notice2.content,
            post_at: notice2.post_at.strftime('%Y-%m-%d')
          }
        ]
      }
      expect(response.body).to be_json_as(json)
    end
  end
end

describe 'GET /messages', autodoc: true do
  context 'ログインしていない場合' do
    it '401が返ってくること' do
      get '/user'
      expect(response.status).to eq 401
    end
  end

  context 'ユーザーにメッセージがある場合' do
    let!(:user) { create(:email_user, :registered) }
    let!(:user2) { create(:email_user, :registered) }
    let!(:message1) { create(:message, user: user, read: true) }
    let!(:message2) { create(:message, user: user2) }
    let!(:message3) { create(:message, user: user) }

    it '200とメッセージ情報を返すこと' do
      get '/messages', '', login_headers(user)
      expect(response.status).to eq 200

      json = {
        messages: [
          {
            id: message3.id,
            content: message3.content,
            read: false,
            created_at: I18n.l(message3.created_at)
          },
          {
            id: message1.id,
            content: message1.content,
            read: true,
            created_at: I18n.l(message1.created_at)
          }
        ]
      }
      expect(response.body).to be_json_as(json)
    end
  end
end
