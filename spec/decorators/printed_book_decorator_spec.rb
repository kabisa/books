require 'rails_helper'

RSpec.describe PrintedBookDecorator do
  let(:decorator) { described_class.new(instance) }
  let(:instance)  { build :printed_book }

  describe '#available_copies' do
    before do
      allow(instance).to receive(:copies_count).and_return(5)
      allow(instance).to receive(:borrowings_count).and_return(3)
    end

    subject { decorator.available_copies }

    it { is_expected.to eql('2 copies') }
  end

  describe '#link_to_borrow' do
    before do
      instance.save
      allow(h).to receive(:policy).and_return(policy_stub)
      allow(decorator).to receive(:'borrowed_by?').and_return(false)
    end

    let(:html) { decorator.link_to_borrow }

    describe 'authorized user' do
      subject           { Capybara.string html }
      let(:policy_stub) { double('BookPolicy', borrow?: true) }

      context 'user is borrowing a copy' do
        before do
          allow(decorator).to receive(:'borrowed_by?').and_return(true)
          allow(decorator).to receive(:copies).and_return(double('copies', borrowables: [1]))
          allow(decorator).to receive(:borrow_by).and_return(borrowing)
        end

        let(:borrowing) { build_stubbed(:borrowing) }

        it { is_expected.to have_css('form[method="post"][action^="/borrowings"][data-remote="true"]') }
        it { is_expected.to have_css('form input[name="_method"][value="delete"]', visible: false) }
        it { is_expected.to have_css('form input.dropdown-item[value="Return book"]') }
      end

      context 'copy is not borrowable' do
        before { allow(decorator).to receive(:copies).and_return(double('copies', borrowables: [])) }

        it { is_expected.to have_css('button.dropdown-item[disabled="disabled"]', text: 'Borrow') }
      end

      context 'copy is available on one location' do
        before { allow(decorator).to receive(:copies).and_return(double('copies', borrowables: [1])) }

        it { is_expected.to have_css('form[method="post"][action^="/borrowings"][data-remote="true"]') }
        it { is_expected.to have_css('form input.dropdown-item[value="Borrow"]') }
      end

      context 'copy is available on multiple locations' do
        before do
          allow(decorator).to receive(:copies).and_return(double('copies', borrowables: borrowables))
          allow(h).to receive(:dom_id).and_return(dom_id)
        end

        let(:borrowables) { build_stubbed_list(:copy, 2) }
        let(:dom_id)      { 'dom-id' }

        it { is_expected.to have_css('form input.dropdown-item[value="Borrow..."]') }
      end
    end

    describe 'unauthorized user' do
      subject           { html }
      let(:policy_stub) { double('BookPolicy', borrow?: false) }

      it { is_expected.to be_nil }
    end
  end

  describe '#formatted_type' do
    subject { decorator.formatted_type }

    it { is_expected.to eql('Printed book') }
  end

  describe '#book_type_icon' do
    subject { Capybara.string decorator.book_type_icon }

    it { is_expected.to have_css('i.material-icons[title="Printed book"][data-toggle="tooltip"]', text: 'menu_book') }
  end
end
