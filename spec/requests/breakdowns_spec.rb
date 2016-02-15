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
