require 'rails_helper'

RSpec.describe BootstrapHelper, type: :helper do
  describe '#close_icon' do
    subject       { helper.close_icon }

    it { is_expected.to have_css('button.close[type="button"][aria-label="Close"] span[aria-hidden="true"]', text: '×') }

    describe 'with extra options' do
      subject       { helper.close_icon(options) }
      let(:options) do
        {
          data: {
            action: 'controller#action'
          }
        }
      end

      it { is_expected.to have_css('button.close[data-action="controller#action"]') }
    end
  end
end
