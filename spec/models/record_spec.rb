require 'rails_helper'

RSpec.describe Record, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:category) }
  it { is_expected.to belong_to(:breakdown) }
  it { is_expected.to belong_to(:place) }

  it { is_expected.to validate_presence_of(:published_at) }
  it { is_expected.to validate_presence_of(:charge) }
end
