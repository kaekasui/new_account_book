require 'rails_helper'

RSpec.describe Place, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:categorize_places) }
  it { is_expected.to have_many(:categories).through(:categorize_places) }
end
