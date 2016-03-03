require 'rails_helper'

RSpec.describe CategorizePlace, type: :model do
  it { is_expected.to belong_to(:category) }
  it { is_expected.to belong_to(:place) }
end
