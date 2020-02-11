require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:votes).dependent(:destroy) }
    it { is_expected.to have_many(:likes).dependent(:destroy) }
    it { is_expected.to have_many(:dislikes).dependent(:destroy) }
    it { is_expected.to have_many(:comments).dependent(:destroy) }
    it { is_expected.to have_many(:copies).dependent(:destroy) }
    it { is_expected.to have_and_belong_to_many(:writers) }
    it { is_expected.to accept_nested_attributes_for(:copies).
         allow_destroy(true) }
    it { is_expected.to have_many(:borrowings).through(:copies) }
    it { is_expected.to belong_to(:reedition).optional.class_name('Book') }

    context 'borrowables' do
      subject { instance.copies.borrowables }

      let(:user) { create(:user) }
      let(:instance) do
        book = build(:book)
        book.copies = copies
        book.save
        book
      end

      context 'every copy is borrowable' do
        let(:copies) { build_list(:copy, 2) }
        it           { is_expected.to eql(copies) }
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

  describe 'validations' do
    let(:instance) { create(:book, title: 'Lorem', reedition: reedition) }
    let(:reedition) { create(:book, title: 'Ipsum') }

    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_length_of(:title).is_at_most(255) }
    it { is_expected.to validate_length_of(:summary).is_at_most(2048) }
    it { is_expected.to validate_numericality_of(:num_of_pages).allow_nil.is_greater_than(0).is_less_than(2**15) }
    it { is_expected.to validate_length_of(:link).is_at_most(2048) }

    it do
      expect(build(:book, link: 'invalid')).to be_invalid
    end

    it 'is invalid with only a title but no reedition id' do
      # This can happen when the user tries to replace a book's
      # reedition with an invalid title.
      instance.reedition_title = 'Dolor'
      instance.reedition_id = nil
      expect(instance).to be_invalid
      expect(instance.errors[:reedition_title]).not_to be_empty
    end
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

  describe 'scopes' do
    describe '.complement_with' do
      let!(:book_lorem)     { create(:book, title: 'Lorem', num_of_pages: 10) }
      let!(:book_ipsum)     { create(:book, title: 'Ipsum', num_of_pages: 1000) }
      let!(:book_dolor)     { create(:book, title: 'Dolor', num_of_pages: 500) }
      let(:active_relation) { described_class.where(num_of_pages: (500..)).order(:title).includes(:copies) }

      subject { active_relation.complement_with(title: 'Lorem') }

      it do
        expect(active_relation).not_to include(book_lorem)
        expect(subject).to include(book_lorem)
      end
    end

    describe '.sort_by_num_of_pages_nulls_last_*' do
      let!(:book_wo_pages)     { create(:book, num_of_pages: nil) }
      let!(:book_w_many_pages) { create(:book, num_of_pages: 1000) }
      let!(:book_w_few_pages)  { create(:book, num_of_pages: 10) }

      describe 'ascending' do
        subject { described_class.sort_by_num_of_pages_nulls_last_asc }

        it 'puts books with nulls last' do
          expect(subject.first).to eql(book_w_few_pages)
          expect(subject.second).to eql(book_w_many_pages)
          expect(subject.third).to eql(book_wo_pages)
        end
      end

      describe 'descending' do
        subject { described_class.sort_by_num_of_pages_nulls_last_desc }

        it 'puts books with nulls last' do
          expect(subject.first).to eql(book_w_many_pages)
          expect(subject.second).to eql(book_w_few_pages)
          expect(subject.third).to eql(book_wo_pages)
        end
      end
    end

    describe '.sort_by_published_on_nulls_last_*' do
      let!(:book_wo_date)      { create(:book, published_on: nil) }
      let!(:book_w_early_date) { create(:book, published_on: 1000.days.ago) }
      let!(:book_w_late_date)  { create(:book, published_on: 10.days.ago) }

      describe 'ascending' do
        subject { described_class.sort_by_published_on_nulls_last_asc }

        it 'puts books with nulls last' do
          expect(subject.first).to eql(book_w_early_date)
          expect(subject.second).to eql(book_w_late_date)
          expect(subject.third).to eql(book_wo_date)
        end
      end

      describe 'descending' do
        subject { described_class.sort_by_published_on_nulls_last_desc }

        it 'puts books with nulls last' do
          expect(subject.first).to eql(book_w_late_date)
          expect(subject.second).to eql(book_w_early_date)
          expect(subject.third).to eql(book_wo_date)
        end
      end
    end
  end

  describe '#copies_count' do
    before              { allow(instance).to receive(:copies).and_return(copies_double) }

    subject             { instance.copies_count }

    let(:instance)      { build(:book) }
    let(:copies_double) { [build(:copy, number: 2), build(:copy, number: 3)] }

    it { is_expected.to eql(5) }
  end

  describe '#borrowings_count' do
    before              { allow(instance).to receive(:borrowings).and_return(borrowings_double) }

    subject             { instance.borrowings_count }

    let(:instance)      { build(:book) }
    let(:borrowings_double) { build_list(:borrowing, 3) }

    it { is_expected.to eql(3) }
  end

  describe '#borrow_by' do
    let!(:borrowing) { Borrowing.create(user: user, copy: instance.copies.first) }
    let(:instance)   { create :book, :printed_book }
    let(:user)       { create :user }

    context 'borrowing found' do
      subject { instance.borrow_by(user) }

      it { is_expected.to eql(borrowing) }
    end

    context 'borrowing not found' do
      subject { instance.borrow_by(build(:user)) }

      it { is_expected.to be_nil }
    end
  end

  describe '#borrowed_by?' do
    before         { Borrowing.create(user: user, copy: instance.copies.first) }
    let(:instance) { create :book, :printed_book }
    let(:user)     { create :user }

    context 'borrowing found' do
      subject { instance.borrowed_by?(user) }

      it { is_expected.to be true }
    end

    context 'borrowing not found' do
      subject { instance.borrowed_by?(build(:user)) }

      it { is_expected.to be false }
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

  describe '##reedition_title' do
    let(:instance) { create(:book, title: 'Lorem', reedition: reedition) }
    let(:reedition) { create(:book, title: 'Ipsum') }

    it 'returns the title of the associated reedition' do
      expect(instance.reedition_title).to eql(reedition.title)
    end

    it 'can be overwritten' do
      instance.reedition_title = 'Dolor'
      expect(instance.reedition_title).to eql('Dolor')
    end
  end
end
