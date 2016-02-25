require 'rails_helper'

RSpec.describe Notice, type: :model do
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_length_of(:title).is_at_most(100) }
  it { is_expected.to validate_length_of(:content).is_at_most(10000) }
end
