require 'rails_helper'

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
