require 'rails_helper'

describe 'POST /places/:place_id/categories', autodoc: true do
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
              '', login_headers(user)
        expect(response.status).to eq 422

        json = {
          error_messages: ['カテゴリはすでに存在します']
        }
        expect(response.body).to be_json_as(json)
      end
    end

    context 'まだ設定されていないカテゴリの場合' do
      it '200を返し、お店・施設にカテゴリが登録できること' do
        patch "/places/#{place.id}/categories/#{category.id}",
              '', login_headers(user)
        expect(response.status).to eq 201

        place.reload
        expect(place.categories).to eq [category]
        expect(category.places).to eq [place]
      end
    end
  end
end
