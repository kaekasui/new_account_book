require 'rails_helper'

RSpec.describe CategorizePlace, type: :model do
  it { is_expected.to belong_to(:category) }
  it { is_expected.to belong_to(:place) }

  it do
    is_expected.to validate_uniqueness_of(:category_id).scoped_to(:place_id)
  end
end
