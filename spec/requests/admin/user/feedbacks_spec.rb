# frozen_string_literal: true
require 'rails_helper'

describe 'GET /admin/users/:user_id/feedbacks', autodoc: true do
  let!(:admin_user) { create(:email_user, :admin_user, :registered) }
  let!(:user) { create(:email_user, :registered) }
  let!(:feedback) { create(:feedback, user: user) }

  context 'ログインしていない場合' do
    it '401が返ってくること' do
      get "/admin/users/#{user.id}/feedbacks/", params: ''

      expect(response.status).to eq 401
    end
  end

  context '管理ユーザーとしてログインしている場合' do
    it '200が返り、フィードバック一覧が返ってくること' do
      get "/admin/users/#{user.id}/feedbacks/",
          params: '',
          headers: login_headers(admin_user)

      expect(response.status).to eq 200
      json = {
        feedbacks: [
          {
            id: feedback.id,
            content: feedback.content,
            checked: feedback.checked
          }
        ],
        user_name: user._name
      }
      expect(response.body).to be_json_as(json)
    end
  end
end
