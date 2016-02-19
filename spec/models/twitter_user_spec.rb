require 'rails_helper'

RSpec.describe TwitterUser, type: :model do
  it { is_expected.to have_one(:auth) }
end
