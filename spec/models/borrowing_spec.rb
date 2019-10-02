require 'rails_helper'

RSpec.describe Borrowing, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:copy).counter_cache(true) }
  end

  it { is_expected.to act_as_paranoid }
end
