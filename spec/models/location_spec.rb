require 'rails_helper'

RSpec.describe Location, type: :model do
  describe '#to_label' do
    subject { instance.to_label }
    let(:instance) { build :location }

    it { is_expected.to eql(instance.city) }
  end
end
