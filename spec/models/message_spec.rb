# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Message, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:feedback) }

  it { is_expected.to validate_length_of(:content).is_at_most(10_000) }
  it { is_expected.to validate_presence_of(:user) }
end
