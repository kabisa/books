require 'rails_helper'

RSpec.describe PrintedBookDecorator do
  describe '#available_copies' do
    before          do
      allow(instance).to receive(:copies_count).and_return(5)
      allow(instance).to receive(:borrowings_count).and_return(3)
    end

    subject         { decorator.available_copies }
    let(:instance)  { build :printed_book }
    let(:decorator) { described_class.new(instance) }

    it { is_expected.to eql('2 copies') }
  end

  describe '#borrow_or_return_button' do
    before { allow(decorator).to receive(:'borrowed_by?').and_return(false) }

    subject         { decorator.borrow_or_return_button }
    let(:instance)  { create :printed_book }
    let(:decorator) { described_class.new(instance) }

    context 'user is borrowing a copy' do
      before do
        allow(decorator).to receive(:'borrowed_by?').and_return(true)
        allow(decorator).to receive(:copies).and_return(double('copies', borrowables: [1]))
        allow(decorator).to receive(:borrow_by).and_return(borrowing)
      end

      let(:borrowing) { build_stubbed(:borrowing) }

      it { is_expected.to have_css('form[method="post"][action^="/borrowings"][data-remote="true"]') }
      it { is_expected.to have_css('form input[name="_method"][value="delete"]', visible: false) }
      it { is_expected.to have_css('form input.btn.btn-outline[value="Return Book"]') }
    end

    context 'copy is not borrowable' do
      before { allow(decorator).to receive(:copies).and_return(double('copies', borrowables: [])) }

      it { is_expected.to have_css('button.btn.btn-outline[disabled="disabled"]', text: 'Borrow') }
    end

    context 'copy is available on one location' do
      before { allow(decorator).to receive(:copies).and_return(double('copies', borrowables: [1])) }

      it { is_expected.to have_css('form[method="post"][action^="/borrowings"][data-remote="true"]') }
      it { is_expected.to have_css('form input.btn.btn-outline[value="Borrow"]') }
    end

    context 'copy is available on multiple locations' do
      before do
        allow(decorator).to receive(:copies).and_return(double('copies', borrowables: borrowables))
        allow(h).to receive(:dom_id).and_return(dom_id)
      end
      let(:borrowables) do
        build_stubbed_list(:copy, 2)
      end
      let(:dom_id) { 'dom-id' }

      it { is_expected.to have_css('a.btn.btn-outline[role="button"]', text: 'Borrow...') }
      it { is_expected.to have_css("a[data-toggle='modal'][data-target='##{dom_id}']") }
      it { is_expected.to have_css("##{dom_id}.modal[aria-hidden='true'][role='dialog'][tabindex='-1']") }

      context 'aria-labelledby' do
        it { is_expected.to have_css("##{dom_id}.modal[aria-labelledby=#{dom_id}]") }
        it { is_expected.to have_css(".modal h5##{dom_id}.modal-title", text: "Borrow #{instance.title}" ) }
      end

      context 'modal structure' do
        it { is_expected.to have_css('.modal .modal-dialog[role="document"] .modal-content .modal-header') }
        it { is_expected.to have_css('.modal .modal-dialog[role="document"] .modal-content .modal-body') }
        it { is_expected.to have_css('.modal .modal-dialog[role="document"] .modal-content .modal-footer') }
      end

      context 'modal content' do
        it { is_expected.to have_css('.modal form[method="post"][action^="/borrowings"][data-remote="true"] .modal-content') }
        it { is_expected.to have_css(".modal form input[type='hidden'][name='borrowing[book_id]'][value='#{instance.id}']", visible: false) }

        context 'header' do
          it { is_expected.to have_css(".modal-header h5##{dom_id}", text: "Borrow #{instance.title}") }
        end

        context 'body' do
          it { is_expected.to have_css('.modal-body .form-group label', text: 'Location' ) }
          it { is_expected.to have_css('.modal-body .form-group select[name="borrowing[copy_id]"] option', count: 2 ) }
        end

        context 'footer' do
          it { is_expected.to have_css('.modal-footer a.btn[role="button"][data-dismiss="modal"]', text: 'Cancel') }
          it { is_expected.to have_css(".modal-footer input.btn.btn-primary[value='Borrow'][data-target='##{dom_id}'][data-toggle='modal']") }
        end
      end
    end
  end
end
