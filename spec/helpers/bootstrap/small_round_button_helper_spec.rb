require 'rails_helper'

RSpec.describe BootstrapHelper, type: :helper do
  describe '#small_round_button' do
    subject { helper.small_round_button(classnames) }
    let(:classnames) { nil }

    it { is_expected.to match(/(?=.*\bbtn-float\b)(?=.*\bbtn-sm\b)(?=.*\bbtn\b)(?=.*\bshadow-none\b)/) }

    context 'extra classnames' do
      context 'as string' do
        let(:classnames) { 'lorem ipsum' }

        it { is_expected.to match(/(?=.*\bbtn-float\b)(?=.*\bbtn-sm\b)(?=.*\bbtn\b)(?=.*\bshadow-none\b)(?=.*\blorem\b)(?=.*\bipsum\b)/) }
      end

      context 'as array' do
        let(:classnames) { %w(lorem ipsum) }

        it { is_expected.to match(/(?=.*\bbtn-float\b)(?=.*\bbtn-sm\b)(?=.*\bbtn\b)(?=.*\bshadow-none\b)(?=.*\blorem\b)(?=.*\bipsum\b)/) }
      end
    end
  end
end
