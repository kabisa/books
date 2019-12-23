require 'rails_helper'

RSpec.describe EbookDecorator do
  let(:decorator) { described_class.new(instance) }
  let(:instance)  { build :ebook }

  describe '#borrow_link' do
    let(:html) { decorator.borrow_link }

    before { allow(h).to receive(:policy).and_return(policy_stub) }

    describe 'authorized user' do
      subject           { Capybara.string html }
      let(:policy_stub) { double('BookPolicy', borrow?: true) }

      it { is_expected.to have_css("a[target='_blank'][href='#{instance.link}']", text: 'Download') }
    end

    describe 'unauthorized user' do
      subject           { html }
      let(:policy_stub) { double('BookPolicy', borrow?: false) }

      it { is_expected.to be_nil }
    end
  end

  describe '#formatted_type' do
    subject { decorator.formatted_type }

    it { is_expected.to eql('E-book') }
  end

  describe '#book_type_icon' do
    subject { Capybara.string decorator.book_type_icon }

    it { is_expected.to have_css('i.material-icons[title="E-book"][data-toggle="tooltip"]', text: 'tablet_android') }
  end

  describe '#hamburger_menu' do
    before do
      allow(h).to receive(:policy).and_return(policy_stub)
      instance.save
    end

    describe 'authorized user' do
      subject { Capybara.string decorator.hamburger_menu }

      let(:policy_stub) { double('BookPolicy', edit?: true, borrow?: true, destroy?: true) }

      it { is_expected.to have_css('.dropdown-menu a.dropdown-item[href$="edit"]', text: 'Edit') }
      it { is_expected.to have_css('.dropdown-menu a.dropdown-item[target="_blank"]', text: 'Download') }
      it { is_expected.to have_css('.dropdown-menu .dropdown-divider') }
      it { is_expected.to have_css('.dropdown-menu a.dropdown-item.text-danger[data-remote="true"][data-method="delete"]', text: 'Delete') }

      it { is_expected.not_to have_css('.dropdown-menu a.dropdown-item', text: /Borrow/) }
      it { is_expected.not_to have_css('.dropdown-menu a.dropdown-item', text: /Return book/) }
    end

    describe 'unauthorized user' do
      subject { decorator.hamburger_menu }

      let(:policy_stub) { double('BookPolicy', edit?: false, borrow?: false, destroy?: false) }

      it { is_expected.to be_nil }
    end
  end

end
