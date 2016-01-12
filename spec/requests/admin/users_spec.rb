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
              type_label_name: admin_user.type_label_name,
              type: admin_user._type,
              status_label_name: admin_user.status_label_name,
              status: admin_user._status,
              email: admin_user.email,
              last_sign_in_at: admin_user.last_sign_in_at.to_s
            },
            {
              id: user.id,
              admin: user.admin?,
              type_label_name: user.type_label_name,
              type: user._type,
              status_label_name: user.status_label_name,
              status: user._status,
              email: user.email,
              last_sign_in_at: user.last_sign_in_at.to_s
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
              type_label_name: user.type_label_name,
              type: user._type,
              status_label_name: user.status_label_name,
              status: user._status,
              email: user.email,
              last_sign_in_at: user.last_sign_in_at.to_s
            }
          ]
        }
        expect(response.body).to be_json_as(json)
      end
    end
  end
end
