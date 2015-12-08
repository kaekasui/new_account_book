require 'rails_helper'

RSpec.describe EmailUser, type: :model do
  describe 'バリデーション' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_length_of(:email).is_at_most(72) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_length_of(:password).is_at_most(72) }
  end

  describe '#password_confirmation' do
    let!(:password) { 'password' }
    let!(:password_confirmation) { 'password' }
    subject do
      build(:email_user, :registered,
            password: password, password_confirmation: password_confirmation)
    end

    context 'パスワードとパスワード（確認）が一致する場合' do
      it 'エラーが発生しないこと' do
        expect(subject).to have(0).errors_on(:password_confirmation)
      end
    end

    context 'パスワードとパスワード（確認）が一致しない場合' do
      let(:password_confirmation) { 'dummy_password' }

      it 'エラーが発生すること' do
        expect(subject).to have(1).errors_on(:password_confirmation)
        expect(subject.errors.full_messages).to eq ['パスワード（確認）とパスワードの入力が一致しません']
      end
    end
  end

  describe '#uniqueness_email' do
    let!(:registered_user) { create(:email_user, :registered) }

    context 'すでに対象のメールアドレスで登録されていた場合' do
      let!(:user) do
        build(:email_user, :registered, email: registered_user.email)
      end

      it 'エラーが発生すること' do
        expect(user).to have(1).errors_on(:email)
        expect(user.errors.full_messages).to eq ['メールアドレスですでに登録されています']
      end
    end
  end
end
