require 'rails_helper'

module Books
  describe VoteStatsComponent, type: :component do
    subject       { Capybara.string html }
    let(:html)    { render_inline(described_class.new(**options)) }
    let(:options) { { like_count: 3, dislike_count: 1 } }

    it { is_expected.to have_content('75%') }
    it { is_expected.to have_css('div', text: '3 likes') }
    it { is_expected.to have_css('div[data-toggle="popover"][data-content*="thumb_up"][data-content*="3"]') }
    it { is_expected.to have_css('div[data-toggle="popover"][data-content*="thumb_down"][data-content*="1"]') }
    it { is_expected.to have_css('.progress .progress-bar.bg-primary') }
  end
end
