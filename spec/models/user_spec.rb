require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to have_many(:feedbacks) }
  it { is_expected.to have_many(:categories) }
  it { is_expected.to have_many(:places) }
  it { is_expected.to have_many(:messages) }
  it { is_expected.to have_many(:records) }
  it { is_expected.to have_many(:tags) }
end
