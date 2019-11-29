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

    describe '#tag_list=' do
      it 'denormalizes when value is a JSON string' do
        instance.tag_list = [{ value: 'dolor' }, { value: 'sit' }].to_json

        expect(instance.tag_list).to include('sit', 'dolor')
      end

      it 'let\'s `acts_as_taggable` handle it otherwise' do
        instance.tag_list = %w(dolor sit)

        expect(instance.tag_list).to include('sit', 'dolor')
      end
    end
  end

  describe 'associations' do
    it { is_expected.to have_many(:votes).dependent(:destroy) }
    it { is_expected.to have_many(:likes).dependent(:destroy) }
    it { is_expected.to have_many(:dislikes).dependent(:destroy) }
    it { is_expected.to have_many(:comments).dependent(:destroy) }
    it { is_expected.to have_many(:copies).dependent(:destroy) }
    it { is_expected.to have_and_belong_to_many(:writers) }
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

  describe '#writer_names=' do
    let(:instance) { build :book }

    context 'with stringified JSON' do
      context 'with existing writers' do
        let!(:writer) { create :writer }

        it 'adds the writer' do
          instance.writer_names = [{ value: writer.name }].to_json
          instance.validate
          expect(instance.writers.size).to be(1)
          #expect(Writer.count).not_to change
        end
      end

      context 'with non-existing writers' do
        it 'adds the writer' do
          instance.writer_names = [{ value: 'Mark Twain' }].to_json
          instance.validate
          expect(instance.writers.size).to be(1)
        end
      end

      context 'with invalid names' do
        it 'invalidates the book' do
          instance.writer_names = [{ value: '' }].to_json
          expect(instance).not_to be_valid
        end

        it 'adds an error to `writer_names`' do
          instance.writer_names = [{ value: '' }].to_json
          instance.validate
          expect(instance.errors[:writer_names]).not_to be_empty
        end
      end
    end

    context 'with a strings' do
      it 'adds the writer' do
        instance.writer_names = 'Stephen King, Mark Twain'
        instance.validate
        expect(instance.writers.size).to be(2)
      end
    end
  end
end
