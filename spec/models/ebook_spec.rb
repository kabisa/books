require 'rails_helper'

RSpec.describe Ebook, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:link) }
    it { is_expected.to validate_length_of(:link).is_at_most(2048) }

    it do
      expect(build(:ebook, link: 'invalid')).to be_invalid
    end
  end
end