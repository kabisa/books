require 'rails_helper'

describe Material::Progress, type: :component do
  subject       { Capybara.string html }
  let(:html)    {  render_inline(described_class.new(options)) }
  let(:options) { { value: value } }
  let(:value)   { { now: 3, min: 0, max: 4 } }

  it { is_expected.to have_css('.progress .progress-bar[role="progressbar"]') }
  it { is_expected.to have_css('.progress-bar[aria-valuemax="4"][aria-valuemin="0"][aria-valuenow="3"]') }
  it { is_expected.to have_css('.progress-bar[style="width: 75%;"]') }

  context 'no min value specified' do
    let(:value) { { now: 3, max: 4 } }

    it { is_expected.to have_css('.progress-bar[aria-valuemax="4"][aria-valuemin="0"][aria-valuenow="3"]') }
    it { is_expected.to have_css('.progress-bar[style="width: 75%;"]') }
  end

  context 'max value is 0' do
    let(:value) { { now: 0, max: 0 } }

    it { is_expected.to have_css('.progress-bar[aria-valuemax="0"][aria-valuemin="0"][aria-valuenow="0"]') }
    it { is_expected.to have_css('.progress-bar[style="width: 0%;"]') }
  end

  context 'background' do
    let(:options) { { value: value, background: :success } }

    it { is_expected.to have_css('.progress-bar.bg-success') }
  end

  context 'html attributes' do
    let(:options) { { value: value, html: { title: 'Lorem', data: { toggle: 'tooltip' }} }}

    it { is_expected.to have_css('.progress[title="Lorem"][data-toggle="tooltip"]') }
  end
end
