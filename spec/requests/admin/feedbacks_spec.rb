# frozen_string_literal: true
require 'rails_helper'

describe 'GET /admin/feedbacks?offset=offset', autodoc: true do
  include ActionView::Helpers::TextHelper

  let!(:user) { create(:email_user, :registered) }
  let!(:admin_user) { create(:email_user, :admin_user, :registered) }
  let!(:feedback) { create(:feedback) }
  let!(:user_feedback) { create(:feedback, :login_user) }

  context 'ログインしていない場合' do
    it '401が返ってくること' do
      get '/admin/feedbacks/', ''

      expect(response.status).to eq 401
    end
  end

  context '一般ユーザーとしてログインしている場合' do
    it '401が返ってくること' do
      get '/admin/feedbacks/', '', login_headers(user)

      expect(response.status).to eq 401
    end
  end

  context '管理ユーザーとしてログインしている場合' do
    context '1ページ以内のフィードバック数の場合' do
      it '200が返り、フィードバック一覧が返ってくること' do
        # TODO: Twitterユーザーのフィードバックを表示する
        get '/admin/feedbacks/', '', login_headers(admin_user)

        expect(response.status).to eq 200
        json = {
          feedbacks: [
            {
              id: user_feedback.id,
              checked: user_feedback.checked,
              email: user_feedback.email,
              user_id: user_feedback.user_id,
              user_name: user_feedback.user.try(:_name),
              content: simple_format(user_feedback.content),
              created_at: I18n.l(user_feedback.created_at)
            },
            {
              id: feedback.id,
              checked: feedback.checked,
              email: feedback.email,
              user_id: feedback.user_id,
              user_name: feedback.user.try(:_name),
              content: simple_format(feedback.content),
              created_at: I18n.l(feedback.created_at)
            }
          ],
          total_count: 2
        }
        expect(response.body).to be_json_as(json)
      end
    end

    context '2ページ以上のフィードバック数の場合' do
      it '200が返り、フィードバック一覧が返ってくること' do
        get '/admin/feedbacks/', { offset: 1 }, login_headers(admin_user)

        expect(response.status).to eq 200
        json = {
          feedbacks: [
            {
              id: feedback.id,
              checked: feedback.checked,
              email: feedback.email,
              user_id: feedback.user_id,
              user_name: feedback.user.try(:_name),
              content: simple_format(feedback.content),
              created_at: I18n.l(feedback.created_at)
            }
          ],
          total_count: 2
        }
        expect(response.body).to be_json_as(json)
      end
    end
  end
end

describe 'PATCH /admin/feedbacks/:feedback_id/check', autodoc: true do
  let!(:admin_user) { create(:email_user, :admin_user, :registered) }
  let!(:feedback) { create(:feedback) }
  let!(:user_feedback) { create(:feedback, :login_user) }

  context 'ログインしていない場合' do
    it '401が返ってくること' do
      patch "/admin/feedbacks/#{feedback.id}/check", ''

      expect(response.status).to eq 401
    end
  end

  context '管理ユーザーとしてログインしている場合' do
    context '管理ユーザーで対応済みにする場合' do
      it '200とチェックのフラグが返ってくること' do
        patch "/admin/feedbacks/#{feedback.id}/check",
              '', login_headers(admin_user)
        expect(response.status).to eq 200
        json = { checked: true }
        expect(response.body).to be_json_as(json)
      end
    end

    context '管理ユーザーで未対応にする場合' do
      it '200とチェックのフラグが返ってくること' do
        feedback.update(checked: true)
        patch "/admin/feedbacks/#{feedback.id}/check",
              '', login_headers(admin_user)
        expect(response.status).to eq 200
        json = { checked: false }
        expect(response.body).to be_json_as(json)
      end
    end
  end
end
