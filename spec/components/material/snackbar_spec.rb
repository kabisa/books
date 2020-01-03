require 'rails_helper'

describe Material::Snackbar, type: :component do
  subject       { Capybara.string html }
  let(:html)    {  render_inline(Material::Snackbar, options) }
  let(:flash)   { { notice: content } }
  let(:options) { { flash: flash } }
  let(:content) { 'Lorem' }

  it { is_expected.to have_css('.snackbar[data-controller="snackbar"][data-target="snackbar.container"]') }
  it { is_expected.to have_css('.snackbar .snackbar-body', text: content) }
  it { is_expected.to have_css('button[data-action="snackbar#hide"]') }

  context 'with action' do
    let(:options) { { flash: flash, action: 'action' } }

    it { is_expected.to have_css('.snackbar .snackbar-body span.snackbar-btn', text: 'action') }
  end

  context' with long text' do
    let(:content) { "Lorem"*20 }

    it { is_expected.to have_css('.snackbar.snackbar-multi-line .snackbar-body', text: content) }
  end
end
