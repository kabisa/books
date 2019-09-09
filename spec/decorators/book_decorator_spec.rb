require 'rails_helper'

RSpec.describe BookDecorator do
  describe '#formatted_type' do
    subject { decorator.formatted_type }
    let(:decorator) { described_class.new(book) }

    describe 'e-book' do
      let(:book) { build :ebook }

      it { is_expected.to eql('E-book') }
    end

    describe 'printed book' do
      let(:book) { build :printed_book }

      it { is_expected.to eql('Printed book') }
    end
  end

  describe '#dom_id' do
    subject { decorator.dom_id }
    let(:decorator) { described_class.new(book) }
    let(:book) { build :ebook }

    it { is_expected.to eql('new_ebook') }
  end
end
