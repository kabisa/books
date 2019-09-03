require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_length_of(:title).is_at_most(255) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:copies).dependent(:destroy) }
    it { is_expected.to accept_nested_attributes_for(:copies).
         allow_destroy(true) }
  end

  describe '.policy_class' do
    subject { described_class.policy_class }

    it { is_expected.to eql(BookPolicy) }
  end

  describe '#to_partial_path' do
    subject { instance.to_partial_path }

    describe 'e-book' do
      let(:instance) { build :ebook }

      it { is_expected.to eql('books/book') }
    end

    describe 'printed book' do
      let(:instance) { build :printed_book }

      it { is_expected.to eql('books/book') }
    end
  end
end
