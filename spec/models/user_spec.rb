require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to have_many(:feedbacks) }
  it { is_expected.to have_many(:categories) }
end