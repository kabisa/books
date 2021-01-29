require 'rails_helper'

module Bootstrap
  describe AlertComponent, type: :component do
    subject       { Capybara.string html }
    let(:html)    { render_inline(described_class.new(options)) }
    let(:options) { { text: text, type: type } }
    let(:text) { 'Lorem' }
    let(:type) { :primary }

    context 'primary' do
      it { is_expected.to have_css('div.alert.alert-primary[role="alert"]', text: text) }
    end

    context 'secondary' do
      let(:type) { :secondary }

      it { is_expected.to have_css('div.alert.alert-secondary[role="alert"]', text: text) }
    end

    context 'danger' do
      let(:type) { :danger }

      it { is_expected.to have_css('div.alert.alert-danger[role="alert"]', text: text) }
    end

    context 'info' do
      let(:type)   { :info }

      it { is_expected.to have_css('div.alert.alert-info[role="alert"]', text: text) }
    end

    context 'success' do
      let(:type) { :success }

      it { is_expected.to have_css('div.alert.alert-success[role="alert"]', text: text) }
    end

    context 'warning' do
      let(:type) { :warning }

      it { is_expected.to have_css('div.alert.alert-warning[role="alert"]', text: text) }
    end

    context 'dark' do
      let(:type)   { :dark }

      it { is_expected.to have_css('div.alert.alert-dark[role="alert"]', text: text) }
    end

    context 'light' do
      let(:type) { :light }

      it { is_expected.to have_css('div.alert.alert-light[role="alert"]', text: text) }
    end

    context 'no type' do
      before do
        options.delete(:type)
      end

      it { is_expected.to have_css('div.alert.alert-light[role="alert"]', text: text) }
    end

    context 'other' do
      let(:type) { :lorem }

      it { is_expected.to have_css('div.alert.alert-light[role="alert"]', text: text) }
    end
  end
end
