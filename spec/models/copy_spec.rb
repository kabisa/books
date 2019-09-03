require 'rails_helper'

RSpec.describe Copy, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:book) }
    it { is_expected.to belong_to(:location) }
  end
end
