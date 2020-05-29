require 'rails_helper'

RSpec.describe BootstrapHelper, type: :helper do
  describe '#fab_class' do
    subject { helper.fab_class(classnames) }
    let(:classnames) { nil }

    it { is_expected.to match(/(?=.*\bbtn-float\b)(?=.*\bbtn\b)/) }

    context 'extra classnames' do
      context 'as string' do
        let(:classnames) { 'lorem ipsum' }

        it do
          is_expected.to match(
            /(?=.*\bbtn-float\b)(?=.*\bbtn\b)(?=.*\blorem\b)(?=.*\bipsum\b)/
          )
        end
      end

      context 'as array' do
        let(:classnames) { %w[lorem ipsum] }

        it do
          is_expected.to match(
            /(?=.*\bbtn-float\b)(?=.*\bbtn\b)(?=.*\blorem\b)(?=.*\bipsum\b)/
          )
        end
      end
    end
  end

  describe '#sm_rnd_btn_class' do
    subject { helper.sm_rnd_btn_class(classnames) }
    let(:classnames) { nil }

    it { is_expected.to eql('btn-sm navbar-toggler') }

    context 'extra classnames' do
      context 'as string' do
        let(:classnames) { 'lorem ipsum' }

        it { is_expected.to eql('btn-sm navbar-toggler lorem ipsum') }
      end

      context 'as array' do
        let(:classnames) { %w[lorem ipsum] }

        it { is_expected.to eql('btn-sm navbar-toggler lorem ipsum') }
      end
    end
  end
end
