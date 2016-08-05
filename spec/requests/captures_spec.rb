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
    let!(:content_type) { { 'Content-Type': 'application/json' } }

    it '201が返ってくること' do
      post '/captures/import',
           params: params.to_json,
           headers: login_headers(user).merge(content_type)
      expect(response.status).to eq 201

      expect(user.captures.count).to eq 5
      capture1 = user.captures.first
      expect(capture1.published_at).to eq '2016-08-01'.to_date
      expect(capture1.category_name).to eq '水道光熱費'
      expect(capture1.breakdown_name).to eq '電気代'
      expect(capture1.place_name).to eq '東京電力'
      expect(capture1.charge).to eq 4500
      expect(capture1.memo).to eq '7月分'
      expect(capture1.tags).to eq 'クレジットカード'
    end
  end
end
