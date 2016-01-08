require 'rails_helper'

describe 'POST /session?email=email&password=password', autodoc: true do
  let!(:user) { create(:email_user, :registered) }
  let!(:admin_user) { create(:email_user, :admin_user, :registered) }

  context 'ログインしていない場合' do
    it '401が返ってくること' do
      get '/admin/users/', ''

      expect(response.status).to eq 401
    end
  end

  context '一般ユーザーとしてログインしている場合' do
    it '401が返ってくること' do
      get '/admin/users/', '', login_headers(user)

      expect(response.status).to eq 401
    end
  end

  context '管理ユーザーとしてログインしている場合' do
    context '1ページ以内のユーザー数の場合' do
      it '200が返り、ユーザー一覧が返ってくること' do
        get '/admin/users/', '', login_headers(admin_user)

        expect(response.status).to eq 200
        json = {
          users: [
            {
              id: admin_user.id,
              admin: admin_user.admin?,
              status: admin_user._status,
              type: admin_user._type,
              email: admin_user.email
            },
            {
              id: user.id,
              admin: user.admin?,
              status: user._status,
              type: user._type,
              email: user.email
            }
          ]
        }
        expect(response.body).to be_json_as(json)
      end
    end

    context '2ページ以上のユーザー数の場合' do
      it '200が返り、ユーザー一覧が返ってくること' do
        get '/admin/users/', { offset: 1 }, login_headers(admin_user)

        expect(response.status).to eq 200
        json = {
          users: [
            {
              id: user.id,
              admin: user.admin?,
              status: user._status,
              type: user._type,
              email: user.email
            }
          ]
        }
        expect(response.body).to be_json_as(json)
      end
    end
  end
end
