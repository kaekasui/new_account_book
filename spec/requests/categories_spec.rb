# frozen_string_literal: true
require 'rails_helper'

describe 'GET /categories', autodoc: true do
  context 'ログインしていない場合' do
    it '401が返ってくること' do
      get '/categories'
      expect(response.status).to eq 401
    end
  end

  context 'メールアドレスのユーザーがログインしている場合' do
    let!(:user) { create(:email_user, :registered) }
    let!(:category) { create(:category, user: user) }
    let!(:category2) { create(:category, user: user) }
    let!(:place) { create(:place, user: user) }

    it '200とカテゴリ一覧を返すこと' do
      category.places << place
      category.save

      get '/categories', '', login_headers(user)
      expect(response.status).to eq 200

      json = {
        categories: [
          {
            id: category.id,
            name: category.name,
            barance_of_payments: category.barance_of_payments,
            breakdowns_count: category.breakdowns.count,
            places_count: 1,
            records_count: 0
          },
          {
            id: category2.id,
            name: category2.name,
            barance_of_payments: category2.barance_of_payments,
            breakdowns_count: category2.breakdowns.count,
            places_count: 0,
            records_count: 0
          }
        ],
        max_category_count: Settings.user.categories.maximum_length
      }
      expect(response.body).to be_json_as(json)
    end
  end
end

describe 'POST /categories', autodoc: true do
  let!(:name) { '名前' }
  let!(:user) { create(:email_user, :registered) }
  let!(:params) { { name: name, barance_of_payments: true } }

  context 'ログインしていない場合' do
    it '401が返ってくること' do
      post '/categories'
      expect(response.status).to eq 401
    end
  end

  context 'メールアドレスのユーザーがログインしている場合' do
    it '201を返し、カテゴリが登録できること' do
      post '/categories', params, login_headers(user)
      expect(response.status).to eq 201

      expect(user.categories.count).to eq 1
      category = Category.last
      expect(category.name).to eq '名前'
      expect(category.barance_of_payments).to be_truthy
    end
  end

  context 'カテゴリが作成上限に達した場合' do
    it '422とエラーメッセージが返ってくること' do
      3.times { create(:category, user: user) }

      post '/categories', params, login_headers(user)
      expect(response.status).to eq 422

      json = {
        error_messages: ['カテゴリの作成上限は3件です']
      }
      expect(response.body).to be_json_as(json)
    end
  end

  context 'カテゴリ名が空の場合' do
    let(:name) { '' }

    it '422とエラーメッセージが返ってくること' do
      post '/categories', params, login_headers(user)
      expect(response.status).to eq 422

      json = {
        error_messages: ['カテゴリは不正な値です']
      }
      expect(response.body).to be_json_as(json)
    end
  end
end

describe 'PATCH /categories/:id', autodoc: true do
  let!(:user) { create(:email_user, :registered) }
  let!(:category) { create(:category, user: user) }

  context 'ログインしていない場合' do
    it '401が返ってくること' do
      patch "/categories/#{category.id}"
      expect(response.status).to eq 401
    end
  end

  context 'メールアドレスのユーザーがログインしている場合' do
    context 'カテゴリ名の値が正しい場合' do
      let!(:params) { { name: '名前', barance_of_payments: true } }

      it '201を返し、カテゴリが登録できること' do
        patch "/categories/#{category.id}", params, login_headers(user)
        expect(response.status).to eq 200

        category.reload
        expect(category.name).to eq params[:name]
        expect(category.barance_of_payments).to eq params[:barance_of_payments]
      end
    end

    context 'カテゴリ名の値が空の場合' do
      let!(:params) { { name: '', barance_of_payments: true } }

      it '201を返し、カテゴリが登録できること' do
        patch "/categories/#{category.id}", params, login_headers(user)
        expect(response.status).to eq 422

        json = {
          error_messages: ['カテゴリ名を入力してください']
        }
        expect(response.body).to be_json_as(json)
      end
    end
  end
end

describe 'DELETE /categories/:id', autodoc: true do
  let!(:user) { create(:email_user, :registered) }
  let!(:category) { create(:category, user: user) }

  context 'ログインしていない場合' do
    it '401が返ってくること' do
      delete "/categories/#{category.id}"
      expect(response.status).to eq 401
    end
  end

  context 'メールアドレスのユーザーがログインしている場合' do
    it '200を返し、カテゴリが削除できること' do
      delete "/categories/#{category.id}", '', login_headers(user)
      expect(response.status).to eq 200

      expect(Category.count).to eq 0
    end
  end

  context '削除対象のカテゴリが複数の内訳を登録していた場合' do
    before do
      create(:breakdown, category: category)
    end

    it '422とエラーメッセージが返ってくること' do
      delete "/categories/#{category.id}", '', login_headers(user)
      expect(response.status).to eq 422
      json = {
        error_messages: ['登録した内訳を削除してから削除してください']
      }
      expect(response.body).to be_json_as(json)
    end
  end

  context '削除対象のカテゴリが複数の収支を登録していた場合' do
    before do
      create(:record, category: category)
    end

    it '422とエラーメッセージが返ってくること' do
      delete "/categories/#{category.id}", '', login_headers(user)
      expect(response.status).to eq 422
      json = {
        error_messages: ['登録した収支を削除してから削除してください']
      }
      expect(response.body).to be_json_as(json)
    end
  end

  context '削除対象のカテゴリが複数の場所を登録していた場合' do
    let!(:place) { create(:place, user: user) }
    before do
      category.places << place
    end

    it '200を返し、カテゴリと関連が削除できること' do
      delete "/categories/#{category.id}", '', login_headers(user)
      expect(response.status).to eq 200

      expect(Category.count).to eq 0
      expect(category.categorize_places.count).to eq 0
    end
  end
end

describe 'POST /categories/sort', autodoc: true do
  context 'ログインしていない場合' do
    it '401が返ってくること' do
      post '/categories/sort'
      expect(response.status).to eq 401
    end
  end

  context 'メールアドレスのユーザーがログインしている場合' do
    let!(:user) { create(:email_user, :registered) }
    let!(:category1) { create(:category, user: user) }
    let!(:category2) { create(:category, user: user) }
    let!(:category3) { create(:category, user: user) }
    let!(:category4) { create(:category, user: user) }
    let!(:params) do
      { sequence: [category3.id, category2.id, category4.id, category1.id] }
    end

    it '200を返し、データが正しいこと' do
      post '/categories/sort', params, login_headers(user)
      expect(response.status).to eq 200

      expect(user.categories.order(:position).map(&:id)).to eq params[:sequence]
    end
  end
end
