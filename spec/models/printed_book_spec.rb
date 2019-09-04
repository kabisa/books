require 'rails_helper'

RSpec.describe PrintedBook, type: :model do
  describe '#copies_count' do
    subject { instance.copies_count }

    let(:instance) do
      create(:printed_book) do |book|
        book.copies.create(location: rome, number: 2)
        book.copies.create(location: florence, number: 3)
      end
    end

    let(:florence) { create :location, city: 'Florence' }
    let(:rome) { create :location, city: 'Rome' }

    it { is_expected.to eql(5) }
  end
end
