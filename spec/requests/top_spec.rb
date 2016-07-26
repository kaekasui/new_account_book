# frozen_string_literal: true
require 'rails_helper'

describe 'GET /', autodoc: true do
  let!(:user) { create(:email_user, :registered) }
  let!(:notice1) { create(:notice, post_at: Time.zone.today) }
  let!(:notice2) { create(:notice, post_at: Time.zone.yesterday) }
  let!(:notice3) { create(:notice, post_at: Time.zone.tomorrow) }

  context 'ログインしていない場合' do
    it '200とお知らせを返すこと' do
      get '/'
      expect(response.status).to eq 200
    end
  end

  it '200とお知らせを返すこと' do
    get '/', params: '', headers: login_headers(user)
    expect(response.status).to eq 200

    json = {
      notices: [
        {
          id: notice1.id,
          title: notice1.title,
          content: notice1.content,
          post_at: notice1.post_at.strftime('%Y-%m-%d')
        },
        {
          id: notice2.id,
          title: notice2.title,
          content: notice2.content,
          post_at: notice2.post_at.strftime('%Y-%m-%d')
        }
      ]
    }
    expect(response.body).to be_json_as(json)
  end
end
