require 'rails_helper'

describe 'GET /categories/:category_id/breakdowns', autodoc: true do
  let!(:user) { create(:email_user, :registered) }
  let!(:category) { create(:category, user: user) }

  context 'ログインしていない場合' do
    it '401が返ってくること' do
      get "/categories/#{category.id}/breakdowns"
      expect(response.status).to eq 401
    end
  end

  context 'メールアドレスのユーザーがログインしている場合' do
    let!(:breakdown) { create(:breakdown, category: category) }

    it '200とカテゴリ一覧を返すこと' do
      get "/categories/#{category.id}/breakdowns", '', login_headers(user)
      expect(response.status).to eq 200

      json = {
        category: {
          name: category.name,
          barance_of_payments: category.barance_of_payments
        },
        breakdowns: [
          {
            id: breakdown.id,
            name: breakdown.name
          }
        ]
      }
      expect(response.body).to be_json_as(json)
    end
  end
end

describe 'POST /categories/:category_id/breakdowns', autodoc: true do
  let!(:user) { create(:email_user, :registered) }
  let!(:category) { create(:category, user: user) }
  let!(:name) { '内訳名' }
  let!(:params) { { category_id: category.id, name: name } }

  context 'ログインしていない場合' do
    it '401が返ってくること' do
      post "/categories/#{category.id}/breakdowns"
      expect(response.status).to eq 401
    end
  end

  context 'ログインしてる場合' do
    it '201が返ってくること' do
      post "/categories/#{category.id}/breakdowns", params, login_headers(user)
      expect(response.status).to eq 201
    end
  end

  context '内訳が作成上限に達した場合' do
    it '422とエラーメッセージが返ってくること' do
      3.times { create(:breakdown, category: category) }

      post "/categories/#{category.id}/breakdowns", params, login_headers(user)
      expect(response.status).to eq 422

      json = {
        error_messages: ['内訳の作成上限は3件です']
      }
      expect(response.body).to be_json_as(json)
    end
  end

  context '内訳名が空の場合' do
    let(:name) { '' }

    it '422とエラーメッセージが返ってくること' do
      post "/categories/#{category.id}/breakdowns", params, login_headers(user)
      expect(response.status).to eq 422

      json = {
        error_messages: ['内訳は不正な値です']
      }
      expect(response.body).to be_json_as(json)
    end
  end
end

describe 'PATCH /categories/:category_id/breakdowns/:id', autodoc: true do
  let!(:user) { create(:email_user, :registered) }
  let!(:category) { create(:category, user: user) }
  let!(:breakdown) { create(:breakdown, category: category) }

  context 'ログインしていない場合' do
    it '401が返ってくること' do
      patch "/categories/#{category.id}/breakdowns/#{breakdown.id}"
      expect(response.status).to eq 401
    end
  end

  context 'ログインしている場合' do
    context '内訳の値が正しい場合' do
      it '200が返ってくること' do
        patch "/categories/#{category.id}/breakdowns/#{breakdown.id}",
              { name: '内訳' }, login_headers(user)
        expect(response.status).to eq 200
        breakdown.reload
        expect(breakdown.name).to eq '内訳'
      end
    end

    context '内訳の値が空の場合' do
      it '200が返ってくること' do
        patch "/categories/#{category.id}/breakdowns/#{breakdown.id}",
              { name: '' }, login_headers(user)
        expect(response.status).to eq 422
        json = {
          error_messages: ['内訳を入力してください']
        }
        expect(response.body).to be_json_as(json)
      end
    end
  end
end

describe 'DELETE /categories/:category_id/breakdowns/:id', autodoc: true do
  let!(:user) { create(:email_user, :registered) }
  let!(:category) { create(:category, user: user) }
  let!(:breakdown) { create(:breakdown, category: category) }

  context 'ログインしていない場合' do
    it '401が返ってくること' do
      delete "/categories/#{category.id}/breakdowns/#{breakdown.id}"
      expect(response.status).to eq 401
    end
  end

  context 'ログインしている場合' do
    it '200が返ってくること' do
      delete "/categories/#{category.id}/breakdowns/#{breakdown.id}",
             '', login_headers(user)
      expect(response.status).to eq 200
    end
  end
end
