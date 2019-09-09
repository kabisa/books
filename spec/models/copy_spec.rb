require 'rails_helper'

RSpec.describe Copy, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:book) }
    it { is_expected.to belong_to(:location) }
    it { is_expected.to have_many(:borrowings).dependent(:destroy) }
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

    describe 'location' do
      subject do
        build(:printed_book) do |book|
          book.copies.clear
          book.copies.build(location: rome, number: 2)
          book.copies.build(location: rome, number: 3)
        end
      end

      let(:florence) { create :location, city: 'Florence' }
      let(:rome) { create :location, city: 'Rome' }

      it 'does not allow duplicate locations' do
        expect(subject).to be_invalid
        expect(subject.errors[:'copies.location']).not_to be_empty
      end
    end
  end
end
