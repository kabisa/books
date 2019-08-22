require 'rails_helper'

RSpec.describe BookType, type: :model do
  describe '.types' do
    subject { described_class.types }

    it { is_expected.to contain_exactly(Ebook, PrintedBook) }
  end

  describe '.book_class' do
    subject { described_class.book_class(type) }

    describe 'Ebook' do
      let(:type) { 'Ebook' }
      it { is_expected.to eql(Ebook) }
    end

    describe 'PrintedBook' do
      let(:type) { 'PrintedBook' }
      it { is_expected.to eql(PrintedBook) }
    end

    describe 'non-Book class' do
      let(:type) { 'User' }
      it { is_expected.to eql(Book) }
    end
  end
end
