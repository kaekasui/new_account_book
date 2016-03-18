require 'rails_helper'

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

    it '200とカテゴリ一覧を返すこと' do
      category.places << place
      category.save

      get '/records/new', '', login_headers(user)
      expect(response.status).to eq 200

      json = {
        categories: [
          {
            id: category.id,
            name: category.name,
            barance_of_payments: category.barance_of_payments,
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
            breakdowns: [],
            places: []
          }
        ],
        user: {
          breakdown_field: true,
          place_field: true,
          memo_field: true
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
  let!(:charge) { '8000' }
  let!(:params) do
    {
      charge: charge, published_at: Time.zone.today,
      category_id: category.id, breakdown_id: breakdown.id, place_id: place.id
    }
  end

  context 'ログインしていない場合' do
    it '401が返ってくること' do
      post '/records', ''

      expect(response.status).to eq 401
    end
  end

  context '正しい値が登録された場合' do
    it '201が返ってくること' do
      post '/records', params, login_headers(user)

      expect(response.status).to eq 201

      record = Record.last
      expect(record.category).to eq category
      expect(record.breakdown).to eq breakdown
      expect(record.place).to eq place
    end
  end

  context '金額が空の場合' do
    let(:charge) { '' }

    it '422とエラーメッセージが返ってくること' do
      post '/records', params, login_headers(user)

      expect(response.status).to eq 422
      json = {
        error_messages: ['金額を入力してください']
      }
      expect(response.body).to be_json_as(json)
    end
  end
end
