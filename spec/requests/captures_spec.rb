# frozen_string_literal: true
require 'rails_helper'

describe 'POST /captures/import', autodoc: true do
  context 'ログインしていない場合' do
    it '401が返ってくること' do
      post '/captures/import'
      expect(response.status).to eq 401
    end
  end

  context 'ログインしている場合' do
    let!(:user) { create(:email_user, :registered) }

    it '201が返ってくること' do
      post '/captures/import', params: '', headers: login_headers(user)
    end
  end
end
