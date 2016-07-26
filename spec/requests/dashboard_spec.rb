# frozen_string_literal: true
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
    context 'データが空の場合' do
      it '200とからの集計結果を返すこと' do
        get '/dashboard', params: '', headers: login_headers(user)
        expect(response.status).to eq 200

        tally = Tally.find_by(user_id: user.id,
                              year: Time.zone.today.year,
                              month: Time.zone.today.month)
        json = {
          updated_at: I18n.l(tally.updated_at),
          data: []
        }
        expect(response.body).to be_json_as(json)
      end
    end

    context 'データが先月分と今月分あり、今月分表示する場合' do
      let!(:last_month_record1) do
        create(:record, published_at: 1.month.ago, user: user)
      end
      let!(:last_month_record2) do
        create(:record, published_at: 1.month.ago + 1.day, user: user)
      end
      let!(:today_record1) { create(:record, user: user) }
      let!(:today_record2) { create(:record, user: user) }
      let!(:today_record3) { create(:record) }

      context 'パラメータがなかった場合' do
        it '200と今月の集計結果を返すこと' do
          get '/dashboard', params: '', headers: login_headers(user)
          expect(response.status).to eq 200

          tally = Tally.find_by(user_id: user.id,
                                year: Time.zone.today.year,
                                month: Time.zone.today.month)
          json = {
            updated_at: I18n.l(tally.updated_at),
            data: [
              date: Time.zone.today.strftime('%Y-%m-%d'),
              plus: today_record1.charge + today_record2.charge,
              minus: 0
            ]
          }
          expect(response.body).to be_json_as(json)
        end
      end

      context '月のパラメータがあった場合' do
        let!(:params) do
          { month: 1.month.ago.month }
        end

        it '200と今月の集計結果を返すこと' do
          get '/dashboard', params: params, headers: login_headers(user)
          expect(response.status).to eq 200

          tally = Tally.find_by(user_id: user.id,
                                year: Time.zone.today.year,
                                month: 1.month.ago.month)
          json = {
            updated_at: I18n.l(tally.updated_at),
            data: [
              {
                date: 1.month.ago.strftime('%Y-%m-%d'),
                plus: last_month_record1.charge,
                minus: 0
              },
              {
                date: (1.month.ago + 1.day).strftime('%Y-%m-%d'),
                plus: last_month_record2.charge,
                minus: 0
              }
            ]
          }
          expect(response.body).to be_json_as(json)
        end
      end
    end
  end
end
