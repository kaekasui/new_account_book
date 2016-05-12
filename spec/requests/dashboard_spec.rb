require 'rails_helper'

describe 'GET /dashboard', autodoc: true do
  let!(:user) { create(:email_user, :registered) }

  context 'ログインしていない場合' do
    it '200とお知らせを返すこと' do
      get '/'
      expect(response.status).to eq 200
    end
  end

  context 'ログインしている場合' do
    it '200とお知らせを返すこと' do
      pending
      get '/dashboard', '', login_headers(user)
      expect(response.status).to eq 200

      json = {
        updated_at: Time.zone.today,
        list: {}
      }
      expect(response.body).to be_json_as(json)
    end
  end
end
