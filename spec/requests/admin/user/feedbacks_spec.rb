require 'rails_helper'

describe 'GET /admin/users/:user_id/feedbacks', autodoc: true do
  include ActionView::Helpers::TextHelper

  let!(:admin_user) { create(:email_user, :admin_user, :registered) }
  let!(:user) { create(:email_user, :registered) }
  let!(:feedback) { create(:feedback, user: user) }

  context 'ログインしていない場合' do
    it '401が返ってくること' do
      get "/admin/users/#{user.id}/feedbacks/", ''

      expect(response.status).to eq 401
    end
  end

  context '管理ユーザーとしてログインしている場合' do
    it '200が返り、フィードバック一覧が返ってくること' do
      get "/admin/users/#{user.id}/feedbacks/", '', login_headers(admin_user)

      expect(response.status).to eq 200
      json = {
        feedbacks: [
          {
            id: feedback.id,
            content: simple_format(feedback.content)
          }
        ]
      }
      expect(response.body).to be_json_as(json)
    end
  end
end
