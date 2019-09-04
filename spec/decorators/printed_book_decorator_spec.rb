require 'rails_helper'

RSpec.describe PrintedBookDecorator do
  describe '#available_copies' do
    before          { allow(instance).to receive(:copies_count).and_return(5) }

    subject         { decorator.available_copies }
    let(:instance)  { build :printed_book }
    let(:decorator) { described_class.new(instance) }

    it { is_expected.to eql('5 copies') }
  end
end
