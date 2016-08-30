# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Tag, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:tagged_records) }
  it { is_expected.to have_many(:records).through(:tagged_records) }

  describe 'バリデーション' do
    it { is_expected.to validate_uniqueness_of(:name).scoped_to(:user_id) }
  end
end
