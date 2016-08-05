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
    let!(:params) do
      {
        'data': [
          ['2016-08-01', '水道光熱費', '電気代', '東京電力', '4500', '7月分', 'クレジットカード'],
          ['2016-08-03', '消耗品費', '雑貨', '', '800', '', ''],
          ['2016-08-03', '飲食費', '飲み物', 'コーヒーショップ', '450', '', 'ICカード,経費,コーヒー'],
          ['2016-08-06', '交際費', 'プレゼント', '', '6000', '山田さん誕生日', 'クレジットカード'],
          ['']
        ]
      }
    end

    it '201が返ってくること' do
      post '/captures/import', params: params.to_json, headers: login_headers(user).merge('Content-Type': 'application/json')
      expect(response.status).to eq 201

      expect(user.captures.count).to eq 5
    end
  end
end
