require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_length_of(:title).is_at_most(255) }
    it { is_expected.to validate_length_of(:summary).is_at_most(2048) }
  end

  it { is_expected.to act_as_paranoid }

  describe 'acts_as_taggable' do
    let(:instance) { build :book }

    it { expect(instance).to respond_to(:tag_list) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:votes).dependent(:destroy) }
    it { is_expected.to have_many(:likes).dependent(:destroy) }
    it { is_expected.to have_many(:dislikes).dependent(:destroy) }
    it { is_expected.to have_many(:copies).dependent(:destroy) }
    it { is_expected.to accept_nested_attributes_for(:copies).
         allow_destroy(true) }

    context 'borrowables' do
      subject { instance.copies.borrowables }

      let(:user) { create(:user) }
      let(:instance) do
        book = build(:printed_book)
        book.copies = copies
        book.save
        book
      end

      context 'every copy is borrowable' do
        let(:copies) { build_list(:copy, 2) }
        it { is_expected.to eql(copies) }
      end

      context 'some copies are borrowable' do
        let(:borrowable_copies) { build_list(:copy, 2) }
        let(:copies)            { borrowable_copies + [unborrowable_copy] }

        let(:unborrowable_copy) do
          build(:copy, number: 1) do |c|
            c.borrowings.build(user: user)
          end
        end

        it { is_expected.to eql(borrowable_copies) }
      end

      context 'no copies are borrowable' do
        let(:copies) { [unborrowable_copy] }

        let(:unborrowable_copy) do
          build(:copy, number: 1) do |c|
            c.borrowings.build(user: user)
          end
        end

        it { is_expected.to be_empty }
      end
    end
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
