# frozen_string_literal: true
require 'rails_helper'

describe 'GET /captures', autodoc: true do
  context 'ログインしていない場合' do
    it '401が返ってくること' do
      get '/captures'
      expect(response.status).to eq 401
    end
  end

  context 'ログインしている場合' do
    let!(:user) { create(:email_user, :registered) }
    let!(:params) do
      {
        'data': [
          ['2016-08-01', '水道光熱費', '電気代', '東京電力', '4500', '7月分', 'クレジットカード'],
          ['2016-08-03', '消耗品費', '雑貨', '', '-800', '', ''],
          ['2016-08-03', '飲食費', '飲み物', 'コーヒーショップ', '450', '', 'ICカード,経費,コーヒー'],
          ['2016-08-06', '', 'プレゼント', '', '6000', '山田さん誕生日', 'クレジットカード'],
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
      captures = user.captures.to_a

      get '/captures', params: '', headers: login_headers(user)
      expect(response.status).to eq 200
      json = {
        captures: [
          {
            id: captures[0].id,
            created_at: I18n.l(captures[0].created_at),
            published_at: '2016-08-01',
            category_name: '水道光熱費',
            breakdown_name: '電気代',
            place_name: '東京電力',
            charge: 4500,
            memo: '7月分',
            tags: 'クレジットカード',
            comment: nil
          },
          {
            id: captures[1].id,
            created_at: I18n.l(captures[1].created_at),
            published_at: '2016-08-03',
            category_name: '消耗品費',
            breakdown_name: '雑貨',
            place_name: '',
            charge: -800,
            memo: '',
            tags: '',
            comment: '金額は0以上の値にしてください'
          },
          {
            id: captures[2].id,
            created_at: I18n.l(captures[2].created_at),
            published_at: '2016-08-03',
            category_name: '飲食費',
            breakdown_name: '飲み物',
            place_name: 'コーヒーショップ',
            charge: 450,
            memo: '',
            tags: 'ICカード,経費,コーヒー',
            comment: nil
          },
          {
            id: captures[3].id,
            created_at: I18n.l(captures[3].created_at),
            published_at: '2016-08-06',
            category_name: '',
            breakdown_name: 'プレゼント',
            place_name: '',
            charge: 6000,
            memo: '山田さん誕生日',
            tags: 'クレジットカード',
            comment: 'カテゴリ名は必須です'
          },
          {
            id: captures[4].id,
            created_at: I18n.l(captures[4].created_at),
            published_at: nil,
            category_name: nil,
            breakdown_name: nil,
            place_name: nil,
            charge: nil,
            memo: nil,
            tags: nil,
            comment: '日付は必須です,カテゴリ名は必須です'
          }
        ]
      }
      expect(response.body).to be_json_as(json)
    end
  end
end

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
