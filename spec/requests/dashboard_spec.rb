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
      it '200とお知らせを返すこと' do
        get '/dashboard', '', login_headers(user)
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
      before do
        create(:record, published_at: 1.month.ago)
        create(:record, published_at: 1.month.ago)
      end
      let!(:today_record1) { create(:record) }
      let!(:today_record2) { create(:record) }

      it '200とお知らせを返すこと' do
        get '/dashboard', '', login_headers(user)
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
  end
end
