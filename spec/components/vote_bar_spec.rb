require 'rails_helper'

describe VoteBar, type: :component do
  subject       { Capybara.string html }
  let(:html)    {  render_inline(described_class.new(options)) }
  let(:options) { { like_count: 75, dislike_count: 25, has_voted: true } }

  it { is_expected.to have_css('.progress .progress-bar[role="progressbar"]') }
  it { is_expected.to have_css('.progress[title="75/25"][data-toggle="tooltip"]') }

  it { is_expected.to have_css('.progress-bar[aria-valuemax="100"][aria-valuemin="0"][aria-valuenow="75"]') }
  it { is_expected.to have_css('.progress-bar[style="width: 75%;"]') }
  it { is_expected.to have_css('.progress-bar.bg-primary') }

  context 'not voted yet' do
    let(:options) { { like_count: 75, dislike_count: 25, has_voted: false } }

    it { is_expected.to have_css('.progress-bar.bg-dark') }
  end

  context 'no votes' do
    let(:options) { { like_count: 0, dislike_count: 0 } }

    it { is_expected.to have_css('.progress[title="0/0"][data-toggle="tooltip"]') }
    it { is_expected.to have_css('.progress-bar[aria-valuemax="0"][aria-valuemin="0"][aria-valuenow="0"]') }
    it { is_expected.to have_css('.progress-bar[style="width: 0%;"]') }
    it { is_expected.to have_css('.progress-bar.bg-dark') }
  end
end
