require 'rails_helper'

RSpec.describe Writer, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(255) }
    it { is_expected.to validate_uniqueness_of(:name).case_insensitive }
  end

  describe 'associations' do
    it { is_expected.to have_and_belong_to_many(:books) }
  end

  describe 'scopes' do
    describe '.with_books' do
      subject { described_class.with_books }

      let!(:writer_w_book) { create(:writer, :with_books) }
      let!(:writer_wo_book) { create(:writer) }

      it { is_expected.to contain_exactly(writer_w_book) }
    end
  end
end
