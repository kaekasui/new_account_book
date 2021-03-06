# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Feedback, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:messages) }
  it { is_expected.to validate_presence_of(:content) }
  it { is_expected.to validate_length_of(:content).is_at_most(10_000) }
  it { is_expected.to validate_length_of(:email).is_at_most(100) }

  context '内容が空の場合' do
    let!(:user) { create(:user, :registered) }

    it 'エラーが発生すること' do
      feedback = Feedback.new(user_id: user.id, content: '')
      feedback.valid?
      expect(feedback.errors.full_messages).to eq ['内容を入力してください']
    end
  end

  context 'emailが空の場合' do
    it 'エラーが発生すること' do
      feedback = Feedback.new(email: '', content: 'Content')
      feedback.valid?
      expect(feedback.errors.full_messages).to eq ['メールアドレスを入力してください']
    end
  end
end
