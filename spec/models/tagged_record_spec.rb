# frozen_string_literal: true
require 'rails_helper'

RSpec.describe TaggedRecord, type: :model do
  it { is_expected.to belong_to(:record) }
  it { is_expected.to belong_to(:tag) }
end
