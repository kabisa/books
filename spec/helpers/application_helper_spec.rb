require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#show_more_link_to' do
    before { allow(helper).to receive(:material_icon).and_return('icon') }

    subject { helper.show_more_link_to(scope, name, options) }

    let(:scope) { double('scope') }
    let(:name) { 'Ipsum' }
    let(:options) { {} }

    it do
      expect(helper).to receive(:link_to_next_page).with(
        scope,
        "icon #{name}",
        hash_including(:data)
      )
      subject
    end
  end

  describe '#link_to_github' do
    subject { Capybara.string html }
    let(:html) { helper.link_to_github }

    it { is_expected.to have_css('a.nav-link') }
    it do
      is_expected.to have_css(
        'a[href="https://github.com/kabisa/books"][target="_blank"]'
      )
    end
    it do
      is_expected.to have_css(
        'a[title="View the repository on GitHub"][data-toggle="tooltip"]'
      )
    end
    it { is_expected.to have_css('a i.fab.fa-github') }
    it { is_expected.to have_css('a', text: 'GitHub') }
  end

  describe '#hamburger_menu' do
    subject { Capybara.string html }
    let(:html) { helper.hamburger_menu { content } }

    context 'with content' do
      let(:content) { 'content' }

      describe 'container' do
        it do
          is_expected.to have_css('.ml-3.dropdown[data-toggle="no-collapse"]')
        end
      end

      describe 'button' do
        it do
          is_expected.to have_css(
            '.dropdown button.btn-sm.navbar-toggler[data-toggle="dropdown"][aria-expanded="false"][aria-haspopup="true"]'
          )
        end
        it do
          is_expected.to have_css(
            '.dropdown button i.material-icons',
            text: 'more_vert'
          )
        end
      end

      describe 'dropdown menu' do
        it do
          is_expected.to have_css(
            '.dropdown .dropdown-menu.menu.dropdown-menu-right',
            text: content
          )
        end
      end
    end

    context 'without content' do
      let(:content) { nil }
      subject { html }

      it { is_expected.to be_nil }
    end
  end
end
