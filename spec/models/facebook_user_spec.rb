# frozen_string_literal: true
require 'rails_helper'

RSpec.describe FacebookUser, type: :model do
  it { is_expected.to have_one(:auth) }
end
