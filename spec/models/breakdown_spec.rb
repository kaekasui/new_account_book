# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Breakdown, type: :model do
  it { is_expected.to belong_to(:category) }
  it { is_expected.to have_many(:records) }

  it { is_expected.to validate_presence_of(:name) }
end
