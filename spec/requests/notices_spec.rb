# frozen_string_literal: true
require 'rails_helper'

describe 'GET /notices/:id', autodoc: true do
  context 'ログインしていない場合' do
    let!(:notice) { create(:notice) }

    it '200が返ってくること' do
      get "/notices/#{notice.id}"
      expect(response.status).to eq 200

      json = {
        title: notice.title,
        content: notice.content,
        post_at: notice.post_at.strftime('%Y-%m-%d')
      }
      expect(response.body).to be_json_as(json)
    end
  end

  context 'メールアドレスのユーザーがログインしている場合' do
    let!(:user) { create(:email_user, :registered) }
    let!(:notice) { create(:notice) }

    it '200とお知らせを返すこと' do
      get "/notices/#{notice.id}", params: '', headers: login_headers(user)
      expect(response.status).to eq 200

      json = {
        title: notice.title,
        content: notice.content,
        post_at: notice.post_at.strftime('%Y-%m-%d')
      }
      expect(response.body).to be_json_as(json)
    end
  end
end
