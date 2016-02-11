require 'rails_helper'

RSpec.describe Breakdown, type: :model do
  it { is_expected.to belong_to(:category) }
end
