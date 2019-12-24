require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#show_more_link_to' do
    before        { allow(helper).to receive(:material_icon).and_return('icon') }

    subject       { helper.show_more_link_to(scope, name, options) }

    let(:scope)   { double('scope') }
    let(:name)    { 'Ipsum' }
    let(:options) {{}}

    it do
      expect(helper).to receive(:link_to_next_page).with(scope, "icon #{name}", hash_including(:data))
      subject
    end
  end

  describe '#link_to_github' do
    subject       { Capybara.string helper.link_to_github }

    it { is_expected.to have_css('a.nav-link') }
    it { is_expected.to have_css('a[href="https://github.com/kabisa/books"][target="_blank"]') }
    it { is_expected.to have_css('a[title="View the repository on GitHub"][data-toggle="tooltip"]') }
    it { is_expected.to have_css('a i.fab.fa-github') }
    it { is_expected.to have_css('a', text: 'GitHub') }
  end

  describe '#hamburger_menu' do

    xit 'Continue here...'

  end
end
