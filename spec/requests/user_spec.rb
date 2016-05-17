require 'rails_helper'

# プロフィール画面
describe 'GET /user', autodoc: true do
  let!(:email) { 'login@example.com' }

  context 'ログインしていない場合' do
    it '401が返ってくること' do
      get '/user'
      expect(response.status).to eq 401
    end
  end

  context '管理者ユーザーがログインしている場合' do
    let!(:user) { create(:email_user, :registered, :admin_user, email: email) }

    it '200とユーザー情報を返すこと' do
      get '/user', '', login_headers(user)
      expect(response.status).to eq 200

      json = {
        id: user.id,
        type: user.type,
        email: user.email,
        new_email: user.new_email,
        nickname: user.nickname,
        user_name: user._name,
        currency: user.currency,
        admin: user.admin,
        max_values: user.each_maximum_values
      }
      expect(response.body).to be_json_as(json)
    end
  end

  context 'メールアドレスのユーザーがログインしている場合' do
    let!(:user) { create(:email_user, :registered, email: email) }

    it '200とユーザー情報を返すこと' do
      get '/user', '', login_headers(user)
      expect(response.status).to eq 200

      json = {
        id: user.id,
        type: user.type,
        email: user.email,
        new_email: user.new_email,
        nickname: user.nickname,
        user_name: user._name,
        currency: user.currency,
        admin: user.admin,
        max_values: user.each_maximum_values
      }
      expect(response.body).to be_json_as(json)
    end
  end

  context 'Twitterユーザーがログインしている場合' do
    let!(:user) { create(:twitter_user, :registered) }

    it '200とユーザー情報を返すこと' do
      get '/user', '', login_headers(user)
      expect(response.status).to eq 200

      json = {
        id: user.id,
        type: user.type,
        email: user.email,
        new_email: user.new_email,
        nickname: user.nickname,
        user_name: user._name,
        currency: user.currency,
        admin: user.admin,
        auth: {
          name: user.auth.name,
          screen_name: user.auth.screen_name
        },
        max_values: user.each_maximum_values
      }
      expect(response.body).to be_json_as(json)
    end
  end

  context 'Facebookユーザーがログインしている場合' do
    let!(:user) { create(:facebook_user, :registered) }

    it '200とユーザー情報を返すこと' do
      get '/user', '', login_headers(user)
      expect(response.status).to eq 200

      json = {
        id: user.id,
        type: user.type,
        email: user.email,
        new_email: user.new_email,
        nickname: user.nickname,
        user_name: user._name,
        currency: user.currency,
        admin: user.admin,
        auth: {
          name: user.auth.name,
          screen_name: user.auth.screen_name
        },
        max_values: user.each_maximum_values
      }
      expect(response.body).to be_json_as(json)
    end
  end
end

# 基本設定画面
describe 'GET /user/settings', autodoc: true do
  let!(:email) { 'login@example.com' }

  context 'ログインしていない場合' do
    it '401が返ってくること' do
      get '/user/settings'
      expect(response.status).to eq 401
    end
  end

  context 'メールアドレスのユーザーがログインしている場合' do
    let!(:user) { create(:email_user, :registered, email: email) }

    it '200とユーザー情報を返すこと' do
      get '/user/settings', '', login_headers(user)
      expect(response.status).to eq 200

      json = {
        id: user.id,
        breakdown_field: user.breakdown_field,
        place_field: user.place_field,
        tag_field: user.tag_field,
        memo_field: user.memo_field,
        currency: user.currency,
        currencies: { yen: '¥', dollar: '$' }
      }
      expect(response.body).to be_json_as(json)
    end
  end
end

# ユーザー情報の更新
describe 'PATCH /user', autodoc: true do
  context 'ログインしていない場合' do
    it '401が返ってくること' do
      patch '/user'
      expect(response.status).to eq 401
    end
  end

  context 'Twitterユーザーがログインしている場合' do
    let!(:user) { create(:twitter_user, :registered) }

    context 'メールアドレスを設定した場合' do
      let!(:new_email) { 'new_email@example.com' }
      let!(:params) { { new_email: new_email } }

      it '200が返りデータが更新されること' do
        patch '/user', params, login_headers(user)
        expect(response.status).to eq 200

        user.reload
        expect(user.new_email).to eq params[:new_email]
        expect(user.email).not_to eq params[:new_email]

        open_email(new_email)
        expect(current_email.subject).to eq '【PIG BOOK β】メールアドレス変更のご案内'
        expect(current_email).to have_content new_email
        expect(current_email).not_to have_content '/user/authorize_email/'
      end

      it 'URLクリックでメールアドレスが更新されること' do
        patch '/user', params, login_headers(user)
        expect(response.status).to eq 200

        user.reload
        expect(user.new_email).to eq params[:new_email]
        expect(user.email).not_to eq params[:new_email]

        open_email(new_email)
        expect(current_email.subject).to eq '【PIG BOOK β】メールアドレス変更のご案内'
        current_email.body =~
          %r{\/user\/authorize_email\?user_id=(.*)&token=(.*)}
        user_id = Regexp.last_match(1)
        token = Regexp.last_match(2)

        params = { user_id: user_id, token: token }
        get '/user/authorize_email', params
        expect(response.status).to eq 302
        user.reload
        expect(user.email).to eq new_email
        expect(user.new_email).to be_blank
      end
    end

    context '空のメールアドレスを設定した場合' do
      let!(:params) { { new_email: '' } }

      it '200が返りデータが更新されること' do
        patch '/user', params, login_headers(user)
        expect(response.status).to eq 200

        user.reload
        expect(user.new_email).to be_blank
        expect(user.email).to be_blank
      end
    end
  end

  context 'メールアドレスのユーザーがログインしている場合' do
    let!(:user) { create(:email_user, :registered) }

    context '上限値以上の文字列のニックネームを設定した場合' do
      let!(:params) { { nickname: 'ニックネーム' * 50 } }

      it '422が返りデータが更新されないこと' do
        patch '/user', params, login_headers(user)
        expect(response.status).to eq 422

        json = {
          error_messages: ['ニックネームは100文字以内で入力してください']
        }
        expect(response.body).to be_json_as(json)
      end
    end

    context 'ニックネームを設定した場合' do
      let!(:params) { { nickname: 'ニックネーム' } }

      it '200が返りデータが更新されること' do
        patch '/user', params, login_headers(user)
        expect(response.status).to eq 200

        user.reload
        expect(user.nickname).to eq 'ニックネーム'
      end
    end

    context 'メールアドレスを設定した場合' do
      let!(:new_email) { 'new_email@example.com' }
      let!(:params) { { new_email: new_email } }

      it '200が返りデータが更新されること' do
        patch '/user', params, login_headers(user)
        expect(response.status).to eq 200

        user.reload
        expect(user.new_email).to eq params[:new_email]
        expect(user.email).not_to eq params[:new_email]

        open_email(new_email)
        expect(current_email.subject).to eq '【PIG BOOK β】メールアドレス変更のご案内'
        expect(current_email).to have_content new_email
        expect(current_email).not_to have_content '/user/authorize_email/'
      end
    end

    context '不正な形式のメールアドレスを設定した場合' do
      let!(:params) { { new_email: 'aaaaa' } }

      it '422が返りデータが更新されないこと' do
        patch '/user', params, login_headers(user)
        expect(response.status).to eq 422

        json = {
          error_messages: ['新しいメールアドレスを正しい形式で入力してください']
        }
        expect(response.body).to be_json_as(json)
      end
    end

    context '空のメールアドレスを設定した場合' do
      let!(:params) { { new_email: '' } }

      it '422が返りデータが更新されないこと' do
        patch '/user', params, login_headers(user)
        expect(response.status).to eq 422

        json = {
          error_messages: ['メールアドレスを入力してください']
        }
        expect(response.body).to be_json_as(json)
      end
    end
  end
end

describe 'PATCH /user/password', autodoc: true do
  let!(:new_password) { 'new_password' }
  let!(:new_password_confirmation) { 'new_password' }

  context 'ログインしていない場合' do
    it '401が返ってくること' do
      patch '/user/password'
      expect(response.status).to eq 401
    end
  end

  context 'Twitterユーザーでログインしている場合' do
    let!(:user) { create(:twitter_user, :registered) }
    let!(:params) do
      { password: new_password, password_confirmation: new_password }
    end

    it '422が返ってくること' do
      patch '/user/password', params, login_headers(user)
      expect(response.status).to eq 422

      json = {
        error_messages: ['パスワードを設定できるアカウントでログインしてください']
      }
      expect(response.body).to be_json_as(json)
    end
  end

  context 'Emailユーザーでログインしている場合' do
    let!(:user) { create(:email_user, :registered) }
    let!(:current_password) { user.password }
    let!(:params) do
      { current_password: current_password,
        password: new_password,
        password_confirmation: new_password_confirmation }
    end

    context '現在のパスワードが空の場合' do
      let(:current_password) { '' }

      it '422が返ってくること' do
        patch '/user/password', params, login_headers(user)
        expect(response.status).to eq 422

        json = {
          error_messages: ['現在のパスワードを入力してください']
        }
        expect(response.body).to be_json_as(json)
      end
    end

    context '現在のパスワードが間違っていた場合' do
      let(:current_password) { user.password + 'dummy' }

      it '422が返ってくること' do
        patch '/user/password', params, login_headers(user)
        expect(response.status).to eq 422

        json = {
          error_messages: ['現在のパスワードは不正な値です']
        }
        expect(response.body).to be_json_as(json)
      end
    end

    context 'パスワードが不一致の場合' do
      let(:new_password_confirmation) { 'new_password_confirmation' }

      it '422が返ってくること' do
        patch '/user/password', params, login_headers(user)
        expect(response.status).to eq 422

        json = {
          error_messages: ['パスワード（確認）とパスワードの入力が一致しません']
        }
        expect(response.body).to be_json_as(json)
      end
    end

    context '正しい値でパスワードを設定していた場合' do
      it '200が返り、更新されること' do
        expect(user.authenticate(new_password)).to be_falsey
        patch '/user/password', params, login_headers(user)
        expect(response.status).to eq 200

        user.reload
        expect(user.authenticate(new_password)).to be_truthy
      end
    end
  end
end

describe 'PATCH /user/setting', autodoc: true do
  context 'ログインしていない場合' do
    it '401が返ってくること' do
      patch '/user/setting'
      expect(response.status).to eq 401
    end
  end

  context 'メールアドレスのユーザーがログインしている場合' do
    let!(:user) { create(:email_user, :registered) }

    context '内訳を非表示にした時' do
      let!(:params) { { breakdown_field: false } }

      it '200が返ってくること' do
        expect(user.breakdown_field).to be_truthy
        patch '/user/setting', params, login_headers(user)
        expect(response.status).to eq 200

        user.reload
        expect(user.breakdown_field).to be_falsey
      end
    end

    context 'お店・施設を表示にした時' do
      let!(:params) { { place_field: true } }

      it '200が返ってくること' do
        expect(user.place_field).to be_truthy
        patch '/user/setting', params, login_headers(user)
        expect(response.status).to eq 200

        user.reload
        expect(user.place_field).to be_truthy
      end
    end
  end
end

describe 'POST /user/send_mail', autodoc: true do
  context 'ログインしていない場合' do
    it '401が返ってくること' do
      post '/user/send_mail'
      expect(response.status).to eq 401
    end
  end

  context 'メールアドレスのユーザーがログインしている場合' do
    let!(:user) { create(:email_user, :registered) }
    let!(:new_email) { 'new_email@example.com' }
    let!(:params) { { new_email: new_email } }

    context '認証待ちのメールアドレスがある場合' do
      it 'メールが送信されること' do
        patch '/user', params, login_headers(user)
        expect(response.status).to eq 200
        user.reload

        open_email(new_email)
        expect(current_email.subject).to eq '【PIG BOOK β】メールアドレス変更のご案内'
        expect(current_email).to have_content new_email
        expect(current_email).not_to have_content '/user/authorize_email/'
        clear_emails

        open_email(new_email)
        expect(current_email).to be_nil

        post '/user/send_mail', nil, login_headers(user)
        expect(response.status).to eq 200
        open_email(new_email)
        expect(current_email.subject).to eq '【PIG BOOK β】メールアドレス変更のご案内'
        expect(current_email).to have_content new_email
        expect(current_email).not_to have_content '/user/authorize_email/'
      end
    end

    context '認証待ちのメールアドレスがある場合' do
      it 'メールが送信されないこと' do
        clear_emails

        open_email(new_email)
        expect(current_email).to be_nil

        post '/user/send_mail', nil, login_headers(user)
        expect(response.status).to eq 422
      end
    end
  end
end
