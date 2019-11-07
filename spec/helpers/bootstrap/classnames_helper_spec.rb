require 'rails_helper'

RSpec.describe BootstrapHelper, type: :helper do
  describe '#fab_class' do
    subject { helper.fab_class(classnames) }
    let(:classnames) { nil }

    it { is_expected.to match(/(?=.*\bbtn-float\b)(?=.*\bbtn\b)/) }

    context 'extra classnames' do
      context 'as string' do
        let(:classnames) { 'lorem ipsum' }

        it { is_expected.to match(/(?=.*\bbtn-float\b)(?=.*\bbtn\b)(?=.*\blorem\b)(?=.*\bipsum\b)/) }
      end

      context 'as array' do
        let(:classnames) { %w(lorem ipsum) }

        it { is_expected.to match(/(?=.*\bbtn-float\b)(?=.*\bbtn\b)(?=.*\blorem\b)(?=.*\bipsum\b)/) }
      end
    end
  end

  describe '#sm_rnd_btn_class' do
    subject { helper.sm_rnd_btn_class(classnames) }
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
