# frozen_string_literal: true
require 'rails_helper'

describe 'GET /records', autodoc: true do
  context 'ログインしていない場合' do
    it '401が返ってくること' do
      get '/records'
      expect(response.status).to eq 401
    end
  end

  context 'メールアドレスのユーザーがログインしている場合' do
    let!(:user) { create(:email_user, :registered) }
    let!(:record1) { create(:record, user: user) }
    let!(:record2) { create(:record, user: user) }
    let!(:record3) do
      create(:record, user: user, published_at: 1.month.ago)
    end
    let!(:tag) { create(:tag, user: user) }

    context '日付のパラメータがある場合' do
      let!(:params) { { date: Time.zone.today } }

      it '200と当日の収支一覧を返すこと' do
        record2.tags << tag

        get '/records', params: params, headers: login_headers(user)
        expect(response.status).to eq 200

        json = {
          records: [
            {
              id: record2.id,
              published_at: record2.published_at.strftime('%Y-%m-%d'),
              charge: record2.charge,
              category_name: record2.category.name,
              breakdown_name: record2.breakdown.try(:name),
              place_name: record2.place.try(:name),
              memo: record2.memo,
              tags: [
                { id: tag.id, name: tag.name, color_code: tag.color_code }
              ]
            },
            {
              id: record1.id,
              published_at: record1.published_at.strftime('%Y-%m-%d'),
              charge: record1.charge,
              category_name: record1.category.name,
              breakdown_name: record1.breakdown.try(:name),
              place_name: record1.place.try(:name),
              memo: record1.memo,
              tags: []
            }
          ],
          total_count: 2,
          user: {
            currency: user.currency
          }
        }
        expect(response.body).to be_json_as(json)
      end
    end

    context '年、月のパラメータがある場合' do
      let!(:params) { { year: 2016, month: 1.month.ago.month } }

      it '200とその年の収支一覧を返すこと' do
        get '/records', params: params, headers: login_headers(user)
        expect(response.status).to eq 200

        json = {
          records: [
            {
              id: record3.id,
              published_at: record3.published_at.strftime('%Y-%m-%d'),
              charge: record3.charge,
              category_name: record3.category.name,
              breakdown_name: record3.breakdown.try(:name),
              place_name: record3.place.try(:name),
              memo: record3.memo,
              tags: []
            }
          ],
          total_count: 1,
          user: {
            currency: user.currency
          }
        }
        expect(response.body).to be_json_as(json)
      end
    end

    context '年のパラメータがある場合' do
      let!(:params) { { year: 2016 } }

      it '200とその年の収支一覧を返すこと' do
        get '/records', params: params, headers: login_headers(user)
        expect(response.status).to eq 200

        json = {
          records: [
            {
              id: record2.id,
              published_at: record2.published_at.strftime('%Y-%m-%d'),
              charge: record2.charge,
              category_name: record2.category.name,
              breakdown_name: record2.breakdown.try(:name),
              place_name: record2.place.try(:name),
              memo: record2.memo,
              tags: []
            },
            {
              id: record1.id,
              published_at: record1.published_at.strftime('%Y-%m-%d'),
              charge: record1.charge,
              category_name: record1.category.name,
              breakdown_name: record1.breakdown.try(:name),
              place_name: record1.place.try(:name),
              memo: record1.memo,
              tags: []
            },
            {
              id: record3.id,
              published_at: record3.published_at.strftime('%Y-%m-%d'),
              charge: record3.charge,
              category_name: record3.category.name,
              breakdown_name: record3.breakdown.try(:name),
              place_name: record3.place.try(:name),
              memo: record3.memo,
              tags: []
            }
          ],
          total_count: 3,
          user: {
            currency: user.currency
          }
        }
        expect(response.body).to be_json_as(json)
      end
    end
  end
end

describe 'GET /records/:id', autodoc: true do
  let!(:user) { create(:email_user, :registered) }
  let!(:record) { create(:record, user: user) }

  context 'ログインしていない場合' do
    it '401が返ってくること' do
      get "/records/#{record.id}"
      expect(response.status).to eq 401
    end
  end

  context 'メールアドレスのユーザーがログインしている場合' do
    it '200と登録データが返ってくること' do
      get "/records/#{record.id}", params: nil, headers: login_headers(user)
      expect(response.status).to eq 200

      json = {
        id: record.id,
        published_at: record.published_at.strftime('%Y-%m-%d'),
        charge: record.charge,
        category_name: record.category.name,
        breakdown_name: record.breakdown.try(:name),
        place_name: record.place.try(:name),
        memo: record.memo,
        tags: record.tags
      }
      expect(response.body).to be_json_as(json)
    end
  end
end

describe 'GET /records/new', autodoc: true do
  context 'ログインしていない場合' do
    it '401が返ってくること' do
      get '/records/new'
      expect(response.status).to eq 401
    end
  end

  context 'メールアドレスのユーザーがログインしている場合' do
    let!(:user) { create(:email_user, :registered) }
    let!(:category) { create(:category, user: user) }
    let!(:category2) { create(:category, user: user) }
    let!(:breakdown) { create(:breakdown, category: category) }
    let!(:place) { create(:place, user: user) }
    let!(:categorize_place) do
      create(:categorize_place, category: category, place: place)
    end

    it '200とカテゴリ一覧を返すこと' do
      get '/records/new', params: '', headers: login_headers(user)
      expect(response.status).to eq 200

      json = {
        categories: [
          {
            id: category.id,
            name: category.name,
            barance_of_payments: category.barance_of_payments,
            _payments_name: category._payments_name,
            breakdowns: [
              id: breakdown.id,
              name: breakdown.name
            ],
            places: [
              id: place.id,
              name: place.name
            ]
          },
          {
            id: category2.id,
            name: category2.name,
            barance_of_payments: category2.barance_of_payments,
            _payments_name: category2._payments_name,
            breakdowns: [],
            places: []
          }
        ],
        total_record_count: 0,
        user: {
          breakdown_field: true,
          place_field: true,
          tag_field: true,
          memo_field: true,
          currency: user.currency,
          max_record_count: Settings.user.records.maximum_length
        }
      }
      expect(response.body).to be_json_as(json)
    end
  end
end

describe 'POST /records', autodoc: true do
  let!(:user) { create(:email_user, :registered) }
  let!(:category) { create(:category, user: user) }
  let!(:breakdown) { create(:breakdown, category: category) }
  let!(:place) { create(:place, user: user) }
  let!(:tag1) { create(:tag, user: user) }
  let!(:tag2) { create(:tag, user: user) }
  let!(:charge) { '8000' }
  let!(:params) do
    {
      charge: charge, published_at: Time.zone.today,
      category_id: category.id, breakdown_id: breakdown.id, place_id: place.id,
      tags: [{ id: tag1.id, name: '既存タグ', color_code: '#ffffff' },
             { id: tag2.id, name: '既存タグ2' },
             { name: '新規タグ' }]
    }
  end

  context 'ログインしていない場合' do
    it '401が返ってくること' do
      post '/records', params: ''

      expect(response.status).to eq 401
    end
  end

  context '正しい値が登録された場合' do
    it '201が返ってくること' do
      post '/records', params: params, headers: login_headers(user)

      expect(response.status).to eq 201

      record = Record.last
      expect(record.category).to eq category
      expect(record.breakdown).to eq breakdown
      expect(record.place).to eq place
      expect(record.tags.count).to eq 3
    end
  end

  context '金額が空の場合' do
    let(:charge) { '' }

    it '422とエラーメッセージが返ってくること' do
      post '/records', params: params, headers: login_headers(user)

      expect(response.status).to eq 422
      json = {
        error_messages: ['金額を入力してください']
      }
      expect(response.body).to be_json_as(json)
    end
  end
end

describe 'POST /records/import', autodoc: true do
  let!(:user) { create(:email_user, :registered) }
  let!(:capture) { create(:capture, user: user) }
  let!(:category) { create(:category, user: user, name: capture.category_name) }
  let!(:breakdown) do
    create(:breakdown, category: category, name: capture.breakdown_name)
  end
  let!(:place) { create(:place, user: user, name: capture.place_name) }

  context 'ログインしていない場合' do
    it '401が返ってくること' do
      post '/records/import', params: { capture_id: capture.id }
      expect(response.status).to eq 401
    end
  end

  context 'ログインしている場合' do
    it '201が返ってくること' do
      place.categories << category
      post '/records/import', params: { user: user, capture_id: capture.id },
                              headers: login_headers(user)
      expect(response.status).to eq 201
      record = user.records.last
      expect(record.published_at).to eq capture.published_at
      expect(record.charge).to eq capture.charge
      expect(record.category.name).to eq capture.category_name
      expect(record.breakdown.try(:name)).to eq capture.breakdown_name
      expect(record.place.try(:name)).to eq capture.place_name
      expect(record.memo).to eq capture.memo
      expect(record.tags.count).to eq 2
    end
  end
end

describe 'GET /records/:id/edit', autodoc: true do
  let!(:user) { create(:email_user, :registered) }
  let!(:category) { create(:category, user: user, position: 1) }
  let!(:category2) { create(:category, user: user, position: 2) }
  let!(:breakdown) { create(:breakdown, category: category) }
  let!(:place) { create(:place, user: user) }
  let!(:record) { create(:record, user: user, category: category) }
  let!(:categorize_place) do
    create(:categorize_place, category: category, place: place)
  end

  context 'ログインしていない場合' do
    it '401が返ってくること' do
      get "/records/#{record.id}/edit"
      expect(response.status).to eq 401
    end
  end

  context 'メールアドレスのユーザーがログインしている場合' do
    it '200とカテゴリ一覧を返すこと' do
      get "/records/#{record.id}/edit", params: '', headers: login_headers(user)
      expect(response.status).to eq 200

      json = {
        categories: [
          {
            id: category.id,
            name: category.name,
            barance_of_payments: category.barance_of_payments,
            _payments_name: category._payments_name,
            breakdowns: [
              id: breakdown.id,
              name: breakdown.name
            ],
            places: [
              id: place.id,
              name: place.name
            ]
          },
          {
            id: category2.id,
            name: category2.name,
            barance_of_payments: category2.barance_of_payments,
            _payments_name: category2._payments_name,
            breakdowns: [],
            places: []
          }
        ],
        user: {
          breakdown_field: true,
          place_field: true,
          tag_field: true,
          memo_field: true,
          currency: user.currency
        },
        record: {
          id: record.id,
          published_at: record.published_at.strftime('%Y-%m-%d'),
          charge: record.charge,
          category_name: record.category.name,
          breakdown_name: record.breakdown.try(:name),
          place_name: record.place.try(:name),
          memo: record.memo,
          tags: record.tags
        }
      }
      expect(response.body).to be_json_as(json)
    end
  end
end

describe 'PATCH /records/:id', autodoc: true do
  let!(:user) { create(:email_user, :registered) }
  let!(:record) { create(:record, user: user) }
  let!(:charge) { '900' }
  let!(:params) do
    {
      charge: charge, published_at: Time.zone.today,
      category: Category.last, breakdown: Breakdown.last, place: Place.last
    }
  end

  context 'ログインしていない場合' do
    it '401が返ってくること' do
      post '/records', params: ''

      expect(response.status).to eq 401
    end
  end

  context '正しい値に更新された場合' do
    it '200が返ってくること' do
      patch "/records/#{record.id}", params: params,
                                     headers: login_headers(user)

      expect(response.status).to eq 200

      record = Record.last
      expect(record.charge).to eq 900
    end
  end

  context '金額が空の場合' do
    let(:charge) { '' }

    it '422とエラーメッセージが返ってくること' do
      patch "/records/#{record.id}", params: params,
                                     headers: login_headers(user)

      expect(response.status).to eq 422
      json = {
        error_messages: ['金額を入力してください']
      }
      expect(response.body).to be_json_as(json)
    end
  end

  context '金額が負の値の場合' do
    let(:charge) { '-20' }

    it '422とエラーメッセージが返ってくること' do
      patch "/records/#{record.id}", params: params,
                                     headers: login_headers(user)

      expect(response.status).to eq 422
      json = {
        error_messages: ['金額は0以上の値にしてください']
      }
      expect(response.body).to be_json_as(json)
    end
  end
end

describe 'DELETE /records/:id', autodoc: true do
  let!(:user) { create(:email_user, :registered) }
  let!(:record) { create(:record, user: user) }

  context 'ログインしていない場合' do
    it '401が返ってくること' do
      delete "/records/#{record.id}"

      expect(response.status).to eq 401
    end
  end

  context 'ログインしている場合' do
    it '200が返ってくること' do
      delete "/records/#{record.id}", params: '', headers: login_headers(user)
      expect(response.status).to eq 200
      expect(Record.count).to eq 0
    end
  end
end
