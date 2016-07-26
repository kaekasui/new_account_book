# frozen_string_literal: true
require 'rails_helper'

describe 'GET /places/:place_id/categories', autodoc: true do
  let!(:user) { create(:email_user, :registered) }
  let!(:place) { create(:place, user: user) }

  context 'ログインしていない場合' do
    it '401が返ってくること' do
      get "/places/#{place.id}/categories"
      expect(response.status).to eq 401
    end
  end

  context 'メールアドレスのユーザーがログインしている場合' do
    let!(:category) { create(:category, :income, user: user) }
    let!(:category2) { create(:category, :income, user: user) }
    let!(:category3) { create(:category, :outgo, user: user) }
    let!(:category4) { create(:category, :outgo, user: user) }

    it '200とカテゴリ一覧を返すこと' do
      place.categories << category

      get "/places/#{place.id}/categories", params: '', headers: login_headers(user)
      expect(response.status).to eq 200

      json = {
        categories: [
          {
            id: category.id,
            name: category.name,
            barance_of_payments: category.barance_of_payments,
            selected_place: true
          },
          {
            id: category2.id,
            name: category2.name,
            barance_of_payments: category2.barance_of_payments,
            selected_place: false
          },
          {
            id: category3.id,
            name: category3.name,
            barance_of_payments: category3.barance_of_payments,
            selected_place: false
          },
          {
            id: category4.id,
            name: category4.name,
            barance_of_payments: category4.barance_of_payments,
            selected_place: false
          }
        ]
      }
      expect(response.body).to be_json_as(json)
    end
  end
end

describe 'PATCH /places/:place_id/categories/:id', autodoc: true do
  let!(:user) { create(:email_user, :registered) }
  let!(:place) { create(:place, user: user) }
  let!(:category) { create(:category, user: user) }

  context 'ログインしていない場合' do
    it '401が返ってくること' do
      patch "/places/#{place.id}/categories/#{category.id}"
      expect(response.status).to eq 401
    end
  end

  context 'メールアドレスのユーザーがログインしている場合' do
    context 'すでに設定されてるカテゴリの場合' do
      before do
        place.categories << category
      end

      it '422とエラーメッセージが返ってくること' do
        patch "/places/#{place.id}/categories/#{category.id}",
              params: '', headers: login_headers(user)
        expect(response.status).to eq 422

        json = {
          error_messages: ['カテゴリとの関係はすでに存在します']
        }
        expect(response.body).to be_json_as(json)
      end
    end

    context 'まだ設定されていないカテゴリの場合' do
      it '200を返し、お店・施設にカテゴリが登録できること' do
        patch "/places/#{place.id}/categories/#{category.id}",
              params: '', headers: login_headers(user)
        expect(response.status).to eq 201

        place.reload
        expect(place.categories).to eq [category]
        expect(category.places).to eq [place]
      end
    end
  end
end

describe 'DELETE /places/:place_id/categories/:id', autodoc: true do
  let!(:user) { create(:email_user, :registered) }
  let!(:place) { create(:place, user: user) }
  let!(:category) { create(:category, user: user) }

  context 'ログインしていない場合' do
    it '401が返ってくること' do
      delete "/places/#{place.id}/categories/#{category.id}"
      expect(response.status).to eq 401
    end
  end

  context 'メールアドレスのユーザーがログインしている場合' do
    context 'すでに設定されてるカテゴリの場合' do
      before do
        place.categories << category
      end

      it '200が返ってくること' do
        delete "/places/#{place.id}/categories/#{category.id}",
               params: '', headers: login_headers(user)
        expect(response.status).to eq 200
      end
    end

    context 'まだ設定されていないカテゴリの場合' do
      it '404が返ってくること' do
        delete "/places/#{place.id}/categories/#{category.id}",
               params: '', headers: login_headers(user)
        expect(response.status).to eq 404
      end
    end
  end
end
