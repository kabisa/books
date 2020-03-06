require 'rails_helper'

describe Bootstrap::Alert, type: :component do
  subject       { Capybara.string html }
  let(:html)    {  render_inline(described_class.new(options)) }
  let(:options) { { content: content, type: type } }
  let(:content) { 'Lorem' }
  let(:type)   { :primary }

  context 'primary' do
    it { is_expected.to have_css('div.alert.alert-primary[role="alert"]', text: content) }
  end

  context 'secondary' do
    let(:type)   { :secondary }

    it { is_expected.to have_css('div.alert.alert-secondary[role="alert"]', text: content) }
  end

  context 'danger' do
    let(:type)   { :danger }

    it { is_expected.to have_css('div.alert.alert-danger[role="alert"]', text: content) }
  end

  context 'info' do
    let(:type)   { :info }

    it { is_expected.to have_css('div.alert.alert-info[role="alert"]', text: content) }
  end

  context 'success' do
    let(:type)   { :success }

    it { is_expected.to have_css('div.alert.alert-success[role="alert"]', text: content) }
  end

  context 'warning' do
    let(:type)   { :warning }

    it { is_expected.to have_css('div.alert.alert-warning[role="alert"]', text: content) }
  end

  context 'dark' do
    let(:type)   { :dark }

    it { is_expected.to have_css('div.alert.alert-dark[role="alert"]', text: content) }
  end

  context 'light' do
    let(:type)   { :light }

    it { is_expected.to have_css('div.alert.alert-light[role="alert"]', text: content) }
  end

  context 'no type' do
    before do
      options.delete(:type)
    end

    it { is_expected.to have_css('div.alert.alert-light[role="alert"]', text: content) }
  end

  context 'other' do
    let(:type)   { :lorem }

    it { is_expected.to have_css('div.alert.alert-light[role="alert"]', text: content) }
  end
end
