require 'rails_helper'

RSpec.describe Copy, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:book) }
    it { is_expected.to belong_to(:location) }
  end

  describe 'validations' do
    context 'number' do
      subject      { build(:copy, book: book, number: number) }
      let(:book)   { build(:printed_book) }
      let(:number) { 1 }

      it { is_expected.to be_valid }

      context 'invalid number' do
        let(:number) { -1 }

        it { is_expected.to be_invalid }
      end

      context 'for printed books' do
        let(:book)   { build(:ebook) }
        let(:number) { -1 }

        it 'ignore invalid number for e-books' do
          expect(subject).to be_valid
        end
      end
    end
  end
end
