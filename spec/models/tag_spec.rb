require 'rails_helper'

RSpec.describe Tag, type: :model do
  it { is_expected.to belong_to(:user) }
end
