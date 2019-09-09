require 'rails_helper'

RSpec.describe PrintedBookDecorator do
  describe '#available_copies' do
    before          do
      allow(instance).to receive(:copies_count).and_return(5)
      allow(instance).to receive(:borrowings_count).and_return(3)
    end

    subject         { decorator.available_copies }
    let(:instance)  { build :printed_book }
    let(:decorator) { described_class.new(instance) }

    it { is_expected.to eql('2 copies') }
  end
end
