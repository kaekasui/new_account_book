require 'rails_helper'

RSpec.describe Auth, type: :model do
  it { is_expected.to belong_to(:twitter_user) }
end
