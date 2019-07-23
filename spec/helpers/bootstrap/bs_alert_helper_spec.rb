require 'rails_helper'

RSpec.describe BootstrapHelper, type: :helper do
  describe '#bs_flash' do
    subject       { helper.bs_flash }
    let(:content) { 'Lorem' }

    context 'success' do
      before { flash[:success] = content }

      it { is_expected.to have_css('div.alert.alert-success[role="alert"]', text: content) }
    end

    context 'notice' do
      before { flash[:notice] = content }

      it { is_expected.to have_css('div.alert.alert-success[role="alert"]', text: content) }
    end

    context 'info' do
      before { flash[:info] = content }

      it { is_expected.to have_css('div.alert.alert-info[role="alert"]', text: content) }
    end

    context 'warning' do
      before { flash[:warning] = content }

      it { is_expected.to have_css('div.alert.alert-warning[role="alert"]', text: content) }
    end

    context 'danger' do
      before { flash[:danger] = content }

      it { is_expected.to have_css('div.alert.alert-danger[role="alert"]', text: content) }
    end

    context 'alert' do
      before { flash[:alert] = content }

      it { is_expected.to have_css('div.alert.alert-danger[role="alert"]', text: content) }
    end

    context 'error' do
      before { flash[:error] = content }

      it { is_expected.to have_css('div.alert.alert-danger[role="alert"]', text: content) }
    end

    context 'others' do
      before { flash[:lorem] = content }

      it { is_expected.to be_empty }
    end

    context 'with options passed' do
      describe 'class' do
        before          { flash[:success] = content }
        subject         { helper.bs_flash options }
        let(:classname) { 'my-classname' }
        let(:options)   { { class: classname } }

        it { is_expected.to have_css('div.alert.alert-success.my-classname[role="alert"]', text: content) }
      end

      describe 'dismissible' do
        before          { flash[:notice] = content }
        subject         { helper.bs_flash options }
        let(:options)   { { dismissible: true } }

        it { is_expected.to have_css('div.alert.alert-success.alert-dismissible.fade.show[role="alert"]', text: content) }
        it { is_expected.to have_css('div.alert button.close[type="button"][data-dismiss="alert"][aria-label="Close"] span[aria-hidden="true"]') }
      end
    end

    context 'multiple flashes' do
      before         { flash[:success] = content1 }
      before         { flash[:info] = content2 }
      let(:content1) { content }
      let(:content2) { content*2 }

      it { is_expected.to have_css('div.alert.alert-success[role="alert"]', text: content1) }
      it { is_expected.to have_css('div.alert.alert-info[role="alert"]', text: content2) }
    end
  end
end
