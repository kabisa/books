require 'rails_helper'

RSpec.describe WriterDecorator do
  let(:decorator) { described_class.new(writer) }

  describe '#first_book_title_and_more' do
    subject { decorator.first_book_title_and_more }

    describe ' with no books' do
      let(:writer) { create(:writer) }
      it { is_expected.to be_nil }
    end

    describe ' with 1 book' do
      let(:writer) do
        create(:writer) { |writer| writer.books.build(title: 'Lorem Ipsum') }
      end
      it { is_expected.to eql('Lorem Ipsum') }
    end
    describe ' with multiple books' do
      let(:writer) do
        create(:writer) do |writer|
          writer.books.build(title: 'Lorem Ipsum')
          writer.books.build(title: 'Dolor Sit')
        end
      end
      it { is_expected.to eql('Dolor Sit +1') }
    end
  end
end
