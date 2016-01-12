require 'rails_helper'

RSpec.describe EmailUser::Password, type: :model do
  let!(:user) { create(:email_user, :registered, email: 'email@example.com') }
  let!(:password_params) do
    {
      password: 'new_password',
      password_confirmation: 'new_password'
    }
  end
  subject(:password) { EmailUser::Password.new(user, password_params) }

  describe 'バリデーション' do
    # it { is_expected.to validate_presence_of(:current_password) }
    # it { is_expected.to validate_length_of(:current_password).is_at_most(72) }
    # TODO: プロフィール変更時に設定する
  end
end
