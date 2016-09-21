# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Capture, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:category) }
  it { is_expected.to belong_to(:breakdown) }
  it { is_expected.to belong_to(:place) }

  describe 'バリデーション' do
    it { is_expected.to validate_presence_of(:published_at) }
    it { is_expected.to validate_presence_of(:category_name) }
    it { is_expected.to validate_length_of(:category_name).is_at_most(100) }
    it { is_expected.to validate_length_of(:breakdown_name).is_at_most(100) }
    it { is_expected.to validate_length_of(:place_name).is_at_most(100) }
    it { is_expected.to validate_length_of(:tags).is_at_most(1000) }
    it { is_expected.to validate_numericality_of(:charge).only_integer }
    it do
      is_expected.to validate_numericality_of(:charge)
        .is_greater_than_or_equal_to(0)
    end
    it do
      is_expected.to validate_numericality_of(:charge)
        .is_less_than_or_equal_to(9_999_999)
    end
    it { is_expected.to validate_length_of(:memo).is_at_most(10_000) }
  end
end
