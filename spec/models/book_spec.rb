require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_length_of(:title).is_at_most(255) }
  end

  describe '.types' do
    subject { described_class.types }

    it { is_expected.to contain_exactly(Ebook, PrintedBook) }
  end

  describe '.policy_class' do
    subject { described_class.policy_class }

    it { is_expected.to eql(BookPolicy) }
  end

  describe '.constantize' do
    it do
      expect(described_class.constantize('Ebook')).to eql(Ebook)
    end

    it do
      expect(described_class.constantize('PrintedBook')).to eql(PrintedBook)
    end

    it do
      expect(described_class.constantize('User')).to eql(Book)
    end

    it do
      expect(described_class.constantize('Lorem')).to eql(Book)
    end
  end
end
