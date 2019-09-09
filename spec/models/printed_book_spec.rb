require 'rails_helper'

RSpec.describe PrintedBook, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:copies) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:borrowings).through(:copies) }
  end

  describe '#copies_count' do
    before { allow(instance).to receive(:copies).and_return(copies_double) }

    subject             { instance.copies_count }

    let(:instance)      { build(:printed_book) }
    let(:copies_double) { [build(:copy, number: 2), build(:copy, number: 3)] }

    it { is_expected.to eql(5) }
  end

  describe '#borrowings_count' do
    before { allow(instance).to receive(:borrowings).and_return(borrowings_double) }

    subject             { instance.borrowings_count }

    let(:instance)      { build(:printed_book) }
    let(:borrowings_double) { build_list(:borrowing, 3) }

    it { is_expected.to eql(3) }
  end

  describe '#borrowed_by?' do
    it do
      pending 'Continue here...'
    end
  end
end
