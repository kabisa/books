require 'rails_helper'

RSpec.describe Copy, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:book) }
    it { is_expected.to belong_to(:location) }
  end

  describe 'validations' do
    it { is_expected.to validate_numericality_of(:number).
         is_greater_than(0).
         only_integer }
  end
end
