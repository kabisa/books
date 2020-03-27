require 'rails_helper'

describe ProfileMenuComponent, type: :component do
  before do
    allow(user).to receive(:avatar?).and_return(has_avatar)
    allow(user).to receive(:avatar_url).and_return(avatar_url)
  end

  subject       { Capybara.string html }

  let(:html)    {  render_inline(described_class.new(options)) }
  let(:options) { { user: user } }
  let(:user) { build(:user, email: email) }
  let(:email) { 'john.doe@example.org' }
  let(:avatar_url) { 'http://example.org/avatar.png' }

  describe 'with avatar' do
    let(:has_avatar) { true }

    it { is_expected.to have_css('a#dropdownMenuLink.navbar-toggler[href="#"][data-toggle="dropdown"][aria-expanded="false"][aria-haspopup="true"]') }
    it { is_expected.to have_css("a img.img-fluid.rounded-circle[src='#{avatar_url}']") }
  end

  describe 'without avatar' do
    let(:has_avatar) { false }

    it { is_expected.to have_css('a#dropdownMenuLink.btn.btn-outline.dropdown-toggle[href="#"][role="button"][data-toggle="dropdown"][aria-expanded="false"][aria-haspopup="true"]') }
    it { is_expected.to have_css('a i.material-icons', text: 'person') }
    it { is_expected.to have_css('a span.clearfix.d-none.d-sm-inline-block', text: email) }
  end
end
