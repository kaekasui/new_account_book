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
          ['2016-08-01', '水道光熱費', '水道代', '東京電力', '4500', '7月分', 'クレジットカード'],
          ['2016-08-03', '消耗品費', '雑貨', '', '-800', '', ''],
          ['2016-08-03', '飲食費', '飲み物', 'コーヒーショップ', '450', '', 'ICカード,経費,コーヒー'],
          ['2016-08-06', '', 'プレゼント', '', '6000', '山田さん誕生日', 'クレジットカード'],
          ['不正な日付', 'カテゴリ' * 30, 'プレゼント', '', '6000', '山田さん誕生日', 'クレジットカード'],
          [''],
          ['2016-08-01', '水道光熱費', '電気代', '東京電力', '4500', '', '', '余分なデータ']
        ]
      }
    end
    let!(:category) { create(:category, user: user, name: '水道光熱費') }
    let!(:breakdown) { create(:breakdown, category: category, name: '電気代') }
    let!(:content_type) { { 'Content-Type': 'application/json' } }

    it '201が返ってくること' do
      post '/captures/import',
           params: params.to_json,
           headers: login_headers(user).merge(content_type)
      expect(response.status).to eq 201

      expect(user.captures.count).to eq 7
      captures = user.captures.to_a

      get '/captures', params: '', headers: login_headers(user)
      expect(response.status).to eq 200
      json = {
        captures: [
          {
            id: captures[6].id,
            created_at: I18n.l(captures[6].created_at),
            published_at: '2016-08-01',
            category_name: '水道光熱費',
            category_id: category.id,
            breakdown_name: '電気代',
            breakdown_id: breakdown.id,
            place_name: '東京電力',
            place_id: nil,
            charge: 4500,
            memo: '',
            tags: ',余分なデータ',
            comment: 'お店・施設名が未登録です'
          },
          {
            id: captures[5].id,
            created_at: I18n.l(captures[5].created_at),
            published_at: nil,
            category_name: nil,
            category_id: nil,
            category_id: nil,
            breakdown_name: nil,
            breakdown_id: nil,
            place_name: nil,
            place_id: nil,
            charge: nil,
            memo: nil,
            tags: nil,
            comment: '日付は必須です,カテゴリ名は必須です'
          },
          {
            id: captures[4].id,
            created_at: I18n.l(captures[4].created_at),
            published_at: nil,
            category_name: 'カテゴリ' * 30,
            category_id: nil,
            breakdown_name: 'プレゼント',
            breakdown_id: nil,
            place_name: '',
            place_id: nil,
            charge: 6000,
            memo: '山田さん誕生日',
            tags: 'クレジットカード',
            comment: '日付は必須です,カテゴリ名は100文字以内で入力してください,カテゴリ名が未登録です,内訳が未登録です'
          },
          {
            id: captures[3].id,
            created_at: I18n.l(captures[3].created_at),
            published_at: '2016-08-06',
            category_name: '',
            category_id: nil,
            breakdown_name: 'プレゼント',
            breakdown_id: nil,
            place_name: '',
            place_id: nil,
            charge: 6000,
            memo: '山田さん誕生日',
            tags: 'クレジットカード',
            comment: 'カテゴリ名は必須です,内訳が未登録です'
          },
          {
            id: captures[2].id,
            created_at: I18n.l(captures[2].created_at),
            published_at: '2016-08-03',
            category_name: '飲食費',
            category_id: nil,
            breakdown_name: '飲み物',
            breakdown_id: nil,
            place_name: 'コーヒーショップ',
            place_id: nil,
            charge: 450,
            memo: '',
            tags: 'ICカード,経費,コーヒー',
            comment: 'カテゴリ名が未登録です,内訳が未登録です,お店・施設名が未登録です'
          },
          {
            id: captures[1].id,
            created_at: I18n.l(captures[1].created_at),
            published_at: '2016-08-03',
            category_name: '消耗品費',
            category_id: nil,
            breakdown_name: '雑貨',
            breakdown_id: nil,
            place_name: '',
            place_id: nil,
            charge: -800,
            memo: '',
            tags: '',
            comment: '金額は0以上の値にしてください,カテゴリ名が未登録です,内訳が未登録です'
          },
          {
            id: captures[0].id,
            created_at: I18n.l(captures[0].created_at),
            published_at: '2016-08-01',
            category_name: '水道光熱費',
            category_id: category.id,
            breakdown_name: '水道代',
            breakdown_id: nil,
            place_name: '東京電力',
            place_id: nil,
            charge: 4500,
            memo: '7月分',
            tags: 'クレジットカード',
            comment: '内訳が未登録です,お店・施設名が未登録です'
          }
        ],
        user_currency: '¥'
      }
      expect(response.body).to be_json_as(json)
    end
  end
end

describe 'GET /capture/:id', autodoc: true do
  let!(:user) { create(:email_user, :registered) }
  let!(:capture) { create(:capture, user: user) }

  context 'ログインしていない場合' do
    it '401が返ってくること' do
      get "/captures/#{capture.id}"
      expect(response.status).to eq 401
    end
  end

  context 'ログインしている場合' do
    it '200とインポート履歴が返ってくること' do
      get "/captures/#{capture.id}",
          params: '',
          headers: login_headers(user)
      expect(response.status).to eq 200
      capture.reload

      json = {
        id: capture.id,
        created_at: capture.created_at.strftime('%Y/%m/%d %H:%M:%S'),
        published_at: capture.published_at.strftime('%Y-%m-%d'),
        category_name: capture.category_name,
        category_id: capture.category_id,
        breakdown_name: capture.breakdown_name,
        breakdown_id: capture.breakdown_id,
        place_name: capture.place_name,
        place_id: capture.place_id,
        charge: capture.charge,
        memo: capture.memo,
        tags: capture.tags,
        comment: capture.comment
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

describe 'PATCH /captures/:id', autodoc: true do
  let!(:user) { create(:email_user, :registered) }
  let!(:capture) { create(:capture, user: user) }
  let!(:params) do
    {
      published_at: '2016-08-08',
      category_name: 'カテゴリ名',
      breakdown_name: '内訳',
      place_name: '場所',
      charge: '2000',
      tags: 'ラベル1,ラベル2,ラベル3',
      memo: '備考'
    }
  end

  context 'ログインしていない場合' do
    it '401が返ってくること' do
      patch "/captures/#{capture.id}", params: params
      expect(response.status).to eq 401
    end
  end

  context 'ログインしている場合' do
    it '200が返ってくること' do
      patch "/captures/#{capture.id}",
            params: params,
            headers: login_headers(user)
      expect(response.status).to eq 200

      capture.reload
      expect(capture.published_at).to eq '2016-08-08'.to_date
      expect(capture.category_name).to eq 'カテゴリ名'
      expect(capture.breakdown_name).to eq '内訳'
      expect(capture.place_name).to eq '場所'
      expect(capture.charge).to eq 2000
      expect(capture.tags).to eq 'ラベル1,ラベル2,ラベル3'
      expect(capture.memo).to eq '備考'
    end
  end
end

describe 'DELETE /captures/:id', autodoc: true do
  let!(:user) { create(:email_user, :registered) }
  let!(:capture) { create(:capture, user: user) }

  context 'ログインしていない場合' do
    it '401が返ってくること' do
      delete "/captures/#{capture.id}"

      expect(response.status).to eq 401
    end
  end

  context 'ログインしている場合' do
    it '200が返ってくること' do
      delete "/captures/#{capture.id}", params: '', headers: login_headers(user)
      expect(response.status).to eq 200
      expect(Capture.count).to eq 0
    end
  end
end
