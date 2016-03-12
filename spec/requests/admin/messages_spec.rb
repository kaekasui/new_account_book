require 'rails_helper'

describe 'GET /admin/messages?offset=offset', autodoc: true do
  let!(:user) { create(:email_user, :registered) }
  let!(:admin_user) { create(:email_user, :admin_user, :registered) }
  let!(:feedback) { create(:feedback, user: user) }
  let!(:message1) { create(:message, user: user) }
  let!(:message2) { create(:message, user: user, feedback: feedback) }

  context 'ログインしていない場合' do
    it '401が返ってくること' do
      get '/admin/messages/', ''

      expect(response.status).to eq 401
    end
  end

  context '一般ユーザーとしてログインしている場合' do
    it '401が返ってくること' do
      get '/admin/messages/', '', login_headers(user)

      expect(response.status).to eq 401
    end
  end

  context '管理ユーザーとしてログインしている場合' do
    context '1ページ以内のメッセージ数の場合' do
      it '200が返り、メッセージ一覧が返ってくること' do
        get '/admin/messages/', '', login_headers(admin_user)

        expect(response.status).to eq 200
        json = {
          messages: [
            {
              id: message2.id,
              user_name: message2.user._name,
              feedback_content: message2.feedback.try(:content),
              content: message2.content
            },
            {
              id: message1.id,
              user_name: message1.user._name,
              feedback_content: message1.feedback.try(:content),
              content: message1.content
            }
          ],
          total_count: 2
        }
        expect(response.body).to be_json_as(json)
      end
    end

    context '2ページ以上のメッセージ数の場合' do
      it '200が返り、メッセージ一覧が返ってくること' do
        get '/admin/messages/', { offset: 1 }, login_headers(admin_user)

        expect(response.status).to eq 200
        json = {
          messages: [
            {
              id: message1.id,
              user_name: message1.user._name,
              feedback_content: message1.feedback.try(:content),
              content: message1.content
            }
          ],
          total_count: 2
        }
        expect(response.body).to be_json_as(json)
      end
    end
  end
end

describe 'POST /admin/users/:user_id/messages', autodoc: true do
  let!(:admin_user) { create(:email_user, :admin_user, :registered) }
  let!(:user) { create(:email_user, :registered) }
  let!(:content) { 'お知らせ内容' }

  context 'ログインしていない場合' do
    it '401が返ってくること' do
      post "/admin/users/#{user.id}/messages/", ''

      expect(response.status).to eq 401
    end
  end

  context 'Emailユーザーのフィードバックに対するメッセージの場合' do
    let!(:feedback) { create(:feedback, user: user) }
    let!(:params) do
      { content: content, feedback_id: feedback.id, user_id: user.id }
    end

    context '正しい値が登録された場合' do
      it '201が返ってくること' do
        post "/admin/users/#{user.id}/messages/",
             params, login_headers(admin_user)

        expect(response.status).to eq 201
      end
    end

    context '値が空の場合' do
      let(:content) { '' }

      it '422とエラーメッセージが返ってくること' do
        post "/admin/users/#{user.id}/messages/",
             params, login_headers(admin_user)

        expect(response.status).to eq 422
        json = {
          error_messages: ['メッセージの内容を入力してください']
        }
        expect(response.body).to be_json_as(json)
      end
    end
  end
end

describe 'PATCH /admin/messages/:id', autodoc: true do
  let!(:user) { create(:email_user, :registered) }
  let!(:admin_user) { create(:email_user, :admin_user, :registered) }
  let!(:message) { create(:message, user: user) }
  let!(:content) { 'メッセージ内容' }
  let!(:params) { { content: content } }

  context 'ログインしていない場合' do
    it '401が返ってくること' do
      patch "/admin/messages/#{message.id}", ''

      expect(response.status).to eq 401
    end
  end

  context '内容が変更された場合' do
    it '200が返ってくること' do
      patch "/admin/messages/#{message.id}", params, login_headers(admin_user)
      expect(response.status).to eq 200
      expect(Message.last.content).to eq 'メッセージ内容'
    end
  end

  context 'メッセージの内容の値が空の場合' do
    let(:content) { '' }

    it '422とエラーメッセージが返ってくること' do
      patch "/admin/messages/#{message.id}", params, login_headers(admin_user)

      expect(response.status).to eq 422
      json = {
        error_messages: ['メッセージの内容を入力してください']
      }
      expect(response.body).to be_json_as(json)
    end
  end
end
